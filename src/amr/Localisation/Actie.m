function [ pred ] = Actie(nParticles,bel, rotAngle,transR,transAngle,robot)
%ACTION Moving the particles according to the odometry + error calculated
%in previous step
%This is done according tot he kinematic model of the iRobot Roomba
%% INITIATE
pred = zeros(nParticles,3);    %Initiating pred matrix for speed

%% Kinematic model


pred(:,3) = fullAngleDeg(bel(:,3) + rotAngle + transAngle);

%transAngle =0;
pred(:,1) = bel(:,1) + transR.*cosd(bel(:,3)+rotAngle+transAngle/2);
pred(:,2) = bel(:,2) + transR.*sind(bel(:,3)+rotAngle+transAngle/2);
%% Checking if particles are valid (W.I.P.) 
for i = 1:length(pred)
    if pred(i,2) <3
        pred(i,1) = robot(1)+ 5*randn(1);
        pred(i,2) = robot(2)+ 5*randn(1);
    end
    if pred(i,1) <3
        pred(i,1) = robot(1)+ 5*randn(1);
        pred(i,2) = robot(2)+ 5*randn(1);
        
    end
    if pred(i,1) >4998
        
        pred(i,1) = robot(1)+ 5*randn(1);
        pred(i,2) = robot(2)+ 5*randn(1);
    end
    if pred(i,2) > 4998
        pred(i,1) = robot(1)+ 5*randn(1);
        pred(i,2) = robot(2)+ 5*randn(1);
    end
    if pred(i,3) <1
        pred(i,3) = pred(i,3)+360;
    end
    if pred(i,3) > 360
        pred(i,3) = pred(i,3)-360;
    end
end

end

