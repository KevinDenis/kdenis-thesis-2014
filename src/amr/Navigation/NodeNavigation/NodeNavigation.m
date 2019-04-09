function [angle_R, nextNode] = NodeNavigation(robotPos, PP, currentNode,d_thr_node)
%[angle_R, nextNode] = NodeNavigation(robotPos, PP, currentNode,d_thr_node)
%   Input Parameters:
%   robotPos    = actual robot position
%   PP          = Path Planning [x(i), y(i)]
%   currentNode = index of current node
%   d_thr_node  = threshhold for next node
%
%   Output parameters:
%   angle_R     = angle to next node
%   nextNode    = next node index
%
%   Other important parameters :
%   d           = true, unmodified range data from the laser scanner
%   D           = modified ranga data, the "true distance" that the robot 
%                 can advance by inflating all obstacles by its radius.           
%   Notes:
%   R-frame is the robot (local) fram

%% Parameters
nextNode=currentNode;
n=length(PP);

for i=currentNode:n
    dx = PP(i,1) - robotPos(1);
    dy = PP(i,2) - robotPos(2);    
    if sqrt(dx^2 + dy^2)  <= d_thr_node
        nextNode=i+1;
    else
        break % furthest point has been found, break loop to  continue.
    end
end
% for no overflow
if nextNode > n
    nextNode = n;
end
dx = PP(nextNode,1) - robotPos(1);
dy = PP(nextNode,2) - robotPos(2);
angle_I_nextNode = atan2(dy,dx);
angle_R = angle_I_nextNode-robotPos(3);
end

