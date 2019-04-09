function xy_int=NodeInterpolation(startNode,endNode,points)
% xy_int=NodeInterpolation(startNode,endNode,points)
% Homebrew interpolation function.
% This function will also give STARTNODE AND ENDNODE !!!!!
% FORMAT
% [x_int(i  ),y_int(i  )]
% [x_int(i+1),y_int(i+1)]
% This function will take into account dx=0 and dy=0, wich the default
% matlab function doesn't.
% Also, gives in "good order", by taking into account -dy and -dx
% An error message will be send if both dx and dy are 0.
%% Calculating parameters
dx= endNode(1)-startNode(1);
dy= endNode(2)-startNode(2);

%% MATLAB parameters interpolation bewteen start and end
x = [startNode(1),endNode(1)];
y = [startNode(2),endNode(2)];


%% Interpolation
if (dx ~= 0) && (dy ~= 0)
%     disp('dx ~= 0 && dy ~= 0 ')
    x_int = linspace(startNode(1),endNode(1),points);
    y_int = interp1(x,y,x_int);
elseif (dx == 0) && (dy ~= 0)
%     disp('dx == 0 ')
    y_int = linspace(startNode(2),endNode(2),points);
    x_int = startNode(1)*ones(1,length(y_int)); 
elseif (dy == 0) && (dx ~= 0)
%     disp('dy == 0 && dx < 0')
    x_int = linspace(startNode(1),endNode(1),points);
    y_int = startNode(2)*ones(1,length(x_int)); 
elseif (dx == 0) && (dy == 0)
%     disp('Error: point is allready on Voronoi Diagram, no interpolation needed')
    x_int = [startNode(1),endNode(1)];
    y_int = [startNode(2),endNode(2)];
end
xy_int=[x_int;y_int]'; % for good formatting [x_int,y_int]
% disp(xy_int)
end
