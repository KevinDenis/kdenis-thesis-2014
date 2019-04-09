function [LeftTic,RightTic] = turnAngle(serPort, roombaSpeed, angle)
% travelDistance(serPort, roombaSpeed, angle)
% Turns the Roomba in radiands. Positive radiands move the
% Roomba CCW, negative angle turns the Roomba CW.
% roombaSpeed should be between 0.025 and 0.5 m/s and positive.
% negative values in speed will be converted.
%
% By Kevin Denis, KU Leuven, 2014-15

%% Parameters
theta=0;
[LeftTic,RightTic] = getEncoders(serPort);
SetFwdVelRadiusRoomba(serPort,0, inf);   %stop

%% Function
    
    % Speed given by user shouldn't be negative
    if (roombaSpeed < 0) 
        disp('WARNING: Speed inputted is negative. Should be positive. Taking the absolute value');
        roombaSpeed = abs(roombaSpeed);
    end
    
    %Speed too low
    if (abs(roombaSpeed) < .025)
        disp('WARNING: Speed inputted is too low. Setting speed to minimum, .025 m/s');
        roombaSpeed = .025;
    end
    
    %If distance is negative, put roombaSpeed negative.
    if (angle < 0)
        roombaSpeed = -1 * roombaSpeed;
        angle=abs(angle); % taking abs so while loop is still ok
    end
    
SetFwdVelRadiusRoomba(serPort,roombaSpeed, eps);  
i=1;
while (theta < angle)
    if i == 0
        pause(0.2)
        [LeftTic,RightTic] = getEncoders(serPort);
    end
    [dtheta,LeftTic,RightTic] = getTrueAngle(serPort,roombaSpeed,LeftTic,RightTic);
    theta=theta+abs(dtheta);
    i=i+1;
end

SetFwdVelRadiusRoomba(serPort, 0, 0);    % halt the Roomba !
[LeftTic,RightTic] = getEncoders(serPort);
%% User Display
if roombaSpeed < 0
    dir = 'CW';
else
    dir = 'CCW';
end

disp(['Roomba just turned ',num2str(angle*180/pi,3), ' degrees ', dir])

end
