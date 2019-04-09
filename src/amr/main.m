%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Template Routine Navigation     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Default values of parameters
    * Distance  [m]
    * Angle     [rad]
    * scan      [dist,angle]
    * Position  [x,y,th]

    _R-frame is the robot (local) frame
    _L-frame is the localisation frame

%}
%% Start-up : add necessary paths to directory and files to workspace
startup

%% Parameters
% Objects 
LocalPort=51068;    % Same as C-code
roomba_COM='/dev/ttyUSB2';  % for LINUX machine
% user
v=0.5;              % m/s, first cycle only, will be adjusted by VPH
t_acc=0.5;          % sec, acceleration time
d_thr_dest=0.25;    % m,
d_thr_node=0.5;       % m,
chargerModule=8;    % needs to be implemented
chargerPos=[32.8283,7.5242,-1.4565];      % needs to be implemented
ds1=0;
ds2=0;
dtheta1=0;
dtheta2=0;
R=0.2;
r=inf;

%% Close all ports in MATLAB if there is an error at start
if ~isempty(instrfindall)
    fclose(instrfindall);
    delete(instrfindall);
end

%% Initialisation Roomba & LIDAR
serPort=RoombaInit(roomba_COM);

%% Read all sensors
[LeftTic,RightTic] = getEncoders(serPort);
[Bump,Drop] = getSafetySensors(serPort);
%Determine start and destination position --> GUI
[startPos_L,startDir_L,startPos,startModule,currentMap ] = startFloorSelect();
[destPos,destModule] = destFloorSelect();

%% Initiating Localization
disp('launch LIDAR & Eclipse if needed, MATLAB will be paused untill then')
[bel,nParticles,nRays,scan,lidarData,obs_in,obs_out,map,rawRayData,rayData,totalProbability,robotPos,robotPlot,w]=LocalizationInit(startPos_L,startDir_L,LocalPort,currentMap);

%% PP and Navigation parameters
% Path Planning
currentModule=startModule;
[PP,~,path_select,~]=PathPlanning(robotPos,startModule,destPos,destModule,d_thr_dest);
incr = ModuleDirection(startModule,destModule,startModule);
[nextMap, nextModule] = ModuleMapChanger(robotPos,currentMap,currentModule,destModule,incr);
if ShortModuleID(startModule)==-1 && incr==-1
    currentMap=currentMap+incr;
end
dr_dest=DistanceCalculator(robotPos,destPos);
PP_length=length(PP);
k=odoCorrectionFactor(incr);

% Navigation parameters
i=1;                %loop counter
nextNode=2;
show_index=2;       % for plotting reasons, don't change
steerAngle_R=0;     % rad
JB_flag=1;          % For initiating JukeBox ( sound for user)
speed_flag=0;       % initialy, the AMR has no speed
tElapsedLidar=zeros(1,1);   % timer, will be taken away in final version
tElapsedLoc=zeros(1,1);     % timer, will be taken away in final version
tElapsedNav=zeros(1,1);     % timer, will be taken away in final version
tElapsedDisp=zeros(1,1);    % timer, will be taken away in final version
tElapsedSensors=zeros(1,1); % timer, will be taken away in final version
tElapsed=zeros(1,1);        % timer, will be taken away in final version    
posResults=zeros(1,2);
nodeResults=zeros(1,2);

%% Node Navigation
while nextNode ~= PP_length && Drop~=1 && Bump~=1
    disp('-------------------------------------------')
    disp(['loopNmbr  ',int2str(i)])
    tStart=tic; % loop timer    
    %% See
    % On board Sensors
    tStartSensors=tic;
    [Bump,Drop] = getSafetySensors(serPort);
    [ds1,dtheta1,LeftTic,RightTic ] = getDistAngle(serPort,v,r,LeftTic,RightTic);
    ds=ds1+ds2;
    dtheta=dtheta1+dtheta2;
    ds1=0; ds2=0; dtheta1=0; dtheta2=0;
    tElapsedSensors(i)=toc(tStartSensors);
    % LIDAR
    tStartLidar=tic;
    scan = getLidarScan(LocalPort); % [dist(m),angle(rad)]
    tElapsedLidar(i)=toc(tStartLidar);
    % Localisation
    tStartLoc=tic;
    [lidarData,robotPos,robotPlot,bel,pred,w]=Localization(nRays,scan,nParticles,steerAngle_R,ds,dtheta,bel,robotPlot,rawRayData,map,w,i);
    tElapsedLoc(i) =toc(tStartLoc);
    
    %% Think : Navigation
    % Distance calculations & map stuff
    tStartNav=tic;
    dr_dest=DistanceCalculator(robotPos,destPos);
    incr = ModuleDirection(startModule,destModule,currentModule);
    [nextMap, nextModule] = ModuleMapChanger(robotPos,currentMap,currentModule,destModule,incr);  
    if nextMap ~= currentMap
        [obs_in,obs_out,map,rawRayData]=Map2Obs(currentMap);
        currentMap = nextMap;
    end
    % just to plot the current Path Planning, not all of it.
    if currentModule ~= nextModule
        currentModule=nextModule;
    end
    % Node Navigation
    [nodeAngle_R,nextNode] = NodeNavigation(robotPos,PP,nextNode,d_thr_node);
    nextNodePos=PP(nextNode,:);   
    % VPH algoritm
    [steerAngle_R,r,v] = VPH(scan,robotPos,nextNodePos,v,t_acc,dr_dest);
    tElapsedNav(i)=toc(tStartNav);
    
    %% Disp 
    tStartDisp=tic;
    PlotLocNav(robotPos,destPos,scan,obs_in,obs_out,PP,pred,currentMap,nextNodePos,map)
    tElapsedDisp(i) = toc(tStartDisp);
    tElapsed(i)=toc(tStart);
    posResults(i,:)=robotPos(1:2);
    nodeResults(i,:)=nextNodePos(1:2);
    %% ACT : Send commands towards actuator
    % Smoother path following : only if angle > 20 degrees 
    % will be send towards actuator.
    steerAngle_R=shortestAngle(steerAngle_R);
    [ds2,dtheta2,LeftTic,RightTic ] = getDistAngle(serPort,v,r,LeftTic,RightTic);
    if abs(steerAngle_R*180/pi) > 45
        tStartDanger=tic;
        [LeftTic,RightTic] = turnAngle(serPort,0.10,steerAngle_R);
        SetFwdVelRadiusRoomba(serPort,v,inf)
        tElapsedDanger=toc(tStartDanger);
        if tElapsedDanger < 0.5
            disp('Roomba didnt turn !!!!!!!!!!!!!!!!!!!!!!!!!')
        end
    else
        steerAngle_R=0;
        SetFwdVelRadiusRoomba(serPort,v,r)
    end
    %% Play it !
    JB_flag=JukeBox(JB_flag,nextNode,PP_length);
    i=i+1;   
    
    disp('   ')
end

PlotLocNav(robotPos,destPos,scan,obs_in,obs_out,PP,pred,currentMap,nextNodePos,map)

% Stopping Roomba
stopRoomba(serPort)

% Playing arrival song
if (nextNode == PP_length)
    JukeBox(7,1,1);
end
figure('name','tElapsed')
histogram(tElapsed)
figure('name','tElapsedDisp')
histogram(tElapsedDisp)
figure('name','tElapsedLidar')
histogram(tElapsedLidar)
figure('name','tElapsedLoc')
histogram(tElapsedLoc)
figure('name','tElapsedNav')
histogram(tElapsedNav)
figure('name','tElapsedSensors')
histogram(tElapsedSensors)

pause()
figure()
for i=1:length(posResults)
    plot(obs_out(:,1), obs_out(:,2),'k'); hold on;
    if ~isempty(obs_in)                     % sometimes obs_in can be empty
        plot(obs_in(:,1), obs_in(:,2),'k');
    end
    plot(PP(:,1),PP(:,2), 'go-','LineWidth',2);
    [col1,col2,col3,col4] = MapID2Modules(currentMap);
    scatter(posResults(i,1),posResults(i,2),'r')
    scatter(nodeResults(i,1),nodeResults(i,2),'k','filled'); hold off
    pause(0.1)
end


%% Roomba : Stop and Close serPort 
fclose(serPort);
delete(serPort);
clear serPort;