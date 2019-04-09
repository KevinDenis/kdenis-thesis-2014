function dr=DistanceCalculator(startPos,endPos)
%dr_dest=DistanceCalculator(robotPos,destPos
%   Distance calculation, from 2 given points
%% Calculations
% Destination
dx = endPos(1) - startPos(1);% m
dy = endPos(2) - startPos(2);% m  
dr = sqrt(dx^2 + dy^2);      % m
end

