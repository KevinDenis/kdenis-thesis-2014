function PlotLocNav(robotPos,destPos,scan,obs_in,obs_out,PP,pred,currentMap,currentNodePos,map)
%PLOTLOCNAV Summary of this function goes here
%   Detailed explanation goes here
    figure(1) 
%   % Robot Path
    plot(obs_out(:,1), obs_out(:,2),'k'); hold on;
    plot(PP(:,1),PP(:,2), 'go-','LineWidth',2);
    plot(robotPos(:,1),robotPos(:,2))
    if ~isempty(obs_in)                     % sometimes obs_in can be empty
        plot(obs_in(:,1), obs_in(:,2),'k');
    end
%   %Robot Positioning
    if ~isempty(pred)
        scatter((pred(:,2))/100,(size(map,1)-pred(:,1))/100,10,'b');
    end
    scatter(robotPos(1), robotPos(2), 200, 'r')
    plot([robotPos(1);robotPos(1)+0.5*cos(robotPos(3))],[robotPos(2);robotPos(2)+0.5*sin(robotPos(3))],'r','LineWidth',2)
    if ~isempty(pred)
        [scan_x,scan_y] = pol2cart(scan(:,2)+robotPos(3), scan(:,1));
        scatter(scan_x+robotPos(1),scan_y+robotPos(2),'r');
    end
    scatter(currentNodePos(1),currentNodePos(2),'k','filled')
    scatter(destPos(1),destPos(2), 'k'); hold off;
    [col1,col2,col3,col4] = MapID2Modules(currentMap);
    axis([5,45,5,45])
    hold off;
end

