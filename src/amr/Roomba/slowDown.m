function [speed_flag]=slowDown(serPort,v,t_acc,speed_flag)
%[speed_flag]=slowDown(serPort,v,t_acc)
%   Input Parameters:
%   serPort    = serial object to communicate with Roomba
%   v_end      = actual robot position
%   t_acc      = acceleration time of the robot
%
%   Output parameters:
%   speed_flag = speed flag, false if Roomba is still
%
%   Notes :
%   Function to control the incremental speed of the Roomba, to avoid to
%   brutal choc's.
global td
a=v/t_acc;
tElapsed=0;
tStart = tic;
if speed_flag == 1
    while tElapsed<t_acc
        v_dec=v-a*tElapsed;
        SetFwdVelRadiusRoomba(serPort,v_dec,inf);
        tElapsed=toc(tStart);
        pause(td);
    end
    SetFwdVelRadiusRoomba(serPort,0,inf); % just to be sure
    speed_flag=0;
end
end

