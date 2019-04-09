function [steerAngle_R,rc,v_next] = VPH(scan,robotPos,targetPos,v,t_acc,dr_dest)
%[steerAngle_R,v_next] = VPH(scan,robotPos,targetPos,v,t_acc,dr_dest)
%TODO
%*  Debug Velocity control
%*  Is the windowed histrogram still usefull ?
% Parmeters
% d = true, unmodified range data from the laser scanner
% D = modified ranga data, the "true distance" that the robot can advance
%     by interpretting each laser pont as a circle, with 1.2*(Radius Robot)
% I-frame is the inertia frame 
% R-frame is the robot (local) frame
% Kevin DENIS, KU Leuven, 2014-15
% Last update 18/04/15.

%% Parameters
% Robot parameters
K_safe=1.2;                     % safty factor
R=K_safe*0.16;                   % radius robot with safetyfactor 20%
K1=5;                          % goal oriented factor   <---- to configure
K2=1;                           % effort oriented factor <---- to configure
K3=1;                           % no influence on chosen angle
wmin=1;                         % windows, will not be very usefull now that we use circles !
v_max=0.50;                     % max speed
a=v/t_acc;                      % max acceleration     <------ first factor to configure
t_cycle=1;                      % cycle time
d_safe=K_safe*(v*t_cycle);      % maybe no K_safe in here, allready in radius !
% Robot Position and angle
x0=robotPos(1);                 % m
y0=robotPos(2);                 % m
theta0=robotPos(3);             % rad
% Target Position and angle
xg=targetPos(1);                % m
yg=targetPos(2);                % m
dx=xg-x0;                       % m, horizontal diff robot-goal
dy=yg-y0;                       % m, vertical diff robot-goal
thetag=atan2(dy,dx);            % rad, angle to goal
thetag_R=thetag-theta0;         % rad, Robot-frame, angle to goal
thetag_R=shortestAngle(thetag_R);

%% A. Modification of Original Information by Kevin Denis
% The raw data gained by laser radar should be adjusted to make it clear 
% how far the robot could reach in each direction.
n=length(scan);
angle_R=scan(:,2);              % rad, R-frame, hoek tot obstacle
angle_R=shortestAngle(angle_R); % rad, Spread it over [-pi,pi]
D = inflateObstacle(scan,R);

%% B. Construction of Threshold Function
% From the view of kinematics, the main purpose of the threshold function 
% is to make sure that there is no crash with obstacles when the robot 
% is moving at a certain speed by setting a safe distance.
H=zeros(n,1);                   % Allocate memory H for distance check
for i=1:n 
    if (D(i)>= d_safe)
        H(i)=1;                 % Safe distance
    end
end

%% C. Selection of candidate angles, with window>wmin
B=zeros(n,1);                   % Allocate memory B for window check
for i=1+wmin:n-wmin
    if H(i)== 1
        B(i)=1;                 % Suppose that window is large enough
        for k=i-wmin:i+wmin
            B(i)=B(i)*H(k);     % If there is one H(k) = 0, B(i)=0                       
        end
    end
end

%% E. Construction of Cost Function
% Generally, the cost functions in other methods are goal-oriented 
% and aim to find out a desired direction that makes the robot 
% closer to the goal position. However, this does not necessarily mean 
% that the robot can reach the goal position in a minimum time.
S=ones(n,1);                    % Allocate memory S effort-goal function
for i=1:n
    th_g=thetag_R;              % goal angle
    th_i=angle_R(i);            % object angle
    dth=shortestAngle(th_g-th_i);
    hg=abs(dth);                % angle, rad, obstacle-assenstelsel
    ho=abs(th_i);               % angle, rad, obstacle-assenstelsel
    S(i)=K1*hg+K2*ho+K3;        % cost function
end

C=zeros(n,1);                   % Allocate memory C cost function
for i=1:n
    C(i)=B(i)*D(i)/S(i);        
end

%% F. Finding desired location
[~,maxIndex]=max(C);
steerAngle_R=angle_R(maxIndex);
rc=0.5/(2*sin(steerAngle_R));
if rc > 2
    rc=inf;
elseif rc<-2
    rc=inf;
    %v_next = 0;
    %disp('vel adj. had to be made !!!!!!!')    
end
    
%% G. Speed Control : Chosen direction and goal distance
% Speed control for chosen distance to obstacle
if sqrt(2*a*D(maxIndex))> v_max
    v_next_dist = v_max;    
else
    v_next_dist = sqrt(2*a*D(maxIndex));
end
% Speed control for goal
if dr_dest < v*t_cycle
    v_next_goal = dr_dest/t_cycle;
else
    v_next_goal = v_max;
end
% Taking the smallest speed
if v_next_dist > v_next_goal
    v_next = v_next_goal;
else
    v_next = v_next_dist;
end

if v_next < 0
    v_next = 0;
    disp('vel adj. had to be made !!!!!!!')
end

%% I. Plots
%     % rad -> deg for visualisation purpose
%     angle_Rdeg=angle_R*180/pi;
%     steerAngle_Rdeg=steerAngle_R*180/pi;
%     thetag_Rdeg=thetag_R*180/pi;
%     
%     % Histrogram
%     figure(1)
%     polar(angle_R, D)
%     title('Modified Distance Histogram')
%     xlabel('Robot-centric angle ( degrees)')
%     ylabel('distance to obstacle')
%     
%     % Binary Histogram
%     figure(2)
%     bar(angle_Rdeg, H)
%     title('Binary Histogram,1 is candidate')
%     xlabel('Robot-centric angle ( degrees)')
%     ylabel('possible angles')
%     
%     % Windowed Binary Histogram
%     figure(3)
%     bar(angle_Rdeg, B)
%     title('Windowed Binary Histogram, 1 is candidate angle')
%     xlabel('Robot-centric angle ( degrees)')
%     ylabel('distance to obstacle')
%     
%     % Cost function
%     figure(4)
%     bar(angle_Rdeg, S)
%     title('Cost function, min is best')
%     xlabel('Robot-centric angle ( degrees)')
%     ylabel('cost')
%     
%     % Angle selection
%     figure(5)
%     bar(angle_Rdeg, C/maxVal,'b')  % max = 1
%     hold on
%     bar(steerAngle_Rdeg,1.2,5,'g')
%     hold on
%     bar(thetag_Rdeg,1,5,'k')
%     title(['Angle selection, green is chosen angle ' num2str(steerAngle_Rdeg) ' degrees' ])
%     xlabel('Robot-centric angle ( degrees)')
%     ylabel('Angle selection')
%     hold off;

end
