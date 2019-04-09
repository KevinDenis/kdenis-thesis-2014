function speed_flag=speedUp(serPort,v_end,t_acc,speed_flag)
%speed_flag=speedUp(serPort,v,t)
%   Input Parameters:
%   serPort    = serial object to communicate with Roomba
%   v_end      = actual robot position
%   t_acc      = acceleration time of the robot
%
%   Output parameters:
%   speed_flag = speed flag, true if Roomba is moving
%
%   Notes :
%   Function to control the incremental speed of the Roomba, to avoid to
%   brutal choc's.
global td
a=v_end/t_acc;
tElapsed=0;
tStart = tic;
v_acc=0;
if speed_flag == 0
    while tElapsed<t_acc && v_acc < v_end
        v_acc=a*tElapsed;
        SetFwdVelRadiusRoomba(serPort,v_acc,inf)
        tElapsed=toc(tStart);
        pause(td)
    end
    SetFwdVelRadiusRoomba(serPort,v_end,inf) % just to be sure end speed is reached
    speed_flag=1; % Robot has speed
end
end
