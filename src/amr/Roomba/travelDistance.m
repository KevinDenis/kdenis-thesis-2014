function travelDistance(serPort, roombaSpeed, distance)
% travelDistance(serPort, roombaSpeed, distance)
% Moves the Roomba the distance entered in meters. Positive distances move the
% Roomba foward, negative distances move the Roomba backwards.
% roombaSpeed should be between 0.025 and 0.5 m/s and positive.
% By Kevin Denis, KU Leuven, 2014

%% Parameters
s=0;
getDistance(serPort); % reset distance sensor

%% Function
    
    %Speed given by user shouldn't be negative
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
    if (distance < 0)
        roombaSpeed = -1 * roombaSpeed;
        distance=abs(distance); % taking abs so while loop is still ok
    end
SetFwdVelRadiusRoomba(serPort, roombaSpeed, inf);   
        
while (s < distance)
    ds=getDistance(serPort);
    s=s+abs(ds); %taking abs so while loop is still ok
end

SetFwdVelRadiusRoomba(serPort, 0, 0);    % halt the Roomba !

%% User Display
if roombaSpeed < 0
    dir = '-';
else
    dir = '';
end

disp(['Roomba just travelled ',dir,num2str(distance,3), 'm'])

end