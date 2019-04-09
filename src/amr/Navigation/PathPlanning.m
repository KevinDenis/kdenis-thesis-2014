function [PP,PP_short,path_select,modules] = PathPlanning(startPos,startModule,destPos,destModule,d_thr_dest)
%[PP,PP_short,path_select,modules] = PathPlanning(startPos,startModule,destPos,destModule,d_thr_dest)
%   This function will plan a path, given a start en destination, passing
%   by the different modules if needed. For example :
%   If my start module is 7, and my destination module is 11, the path
%   planning will pass by module 8, 9, 10.
%   This path planner uses the VoronoiPathPlanning. More info specific function
%
%   Explanation about specific parameters :
%   * PP            : the whole PathPlanning
%   * PP_short      : only start and end destination of each module
%   * path_select   : used to select parts of the PP (only for plots)
%   * modules       : sequence of modules, from start to end module

startModulePos=Module2Pos(startModule);
destModulePos=Module2Pos(destModule);
[modules, incr] = ModuleSequance(startModule,destModule);

PP_short=zeros(length(modules)+2,2);
path_select=zeros(length(modules)+1,2);
PP=zeros(1,2);

endRow = 0;
startRow=endRow+1;
% Module Navigation is needed
if startModule ~= destModule  
    % startPos --> startModule
    [obs_in_module,obs_out_module] = ModuleObstacle(startModule,0);
    optimalPath = VoronoiPathPlanning(startPos,startModulePos,obs_in_module,obs_out_module,d_thr_dest);
    optimalPath_short=[optimalPath(1,1),optimalPath(1,2);optimalPath(end,1),optimalPath(end,2),];
    endRow = endRow+length(optimalPath);
    PP(startRow:endRow,:)=optimalPath;
    path_select(1,:) = [startRow,endRow];
    startRow=endRow+1;
    PP_short(1:2,:)=optimalPath_short; 
    % startModule --> destModule
    for i=1:length(modules)-1
        modulePos=Module2Pos(modules(i));
        nextModulePos=Module2Pos(modules(i+1));
        [obs_in_module,obs_out_module] = ModuleObstacle(modules(i),incr);
        optimalPath = VoronoiPathPlanning(modulePos,nextModulePos,obs_in_module,obs_out_module,d_thr_dest);
        optimalPath_short=[optimalPath(end,1),optimalPath(end,2),];
        endRow = endRow+length(optimalPath);
        PP(startRow:endRow,:)=optimalPath;
        path_select(i+1,:) = [startRow,endRow];
        startRow=endRow+1;
        PP_short(i+2,:)=optimalPath_short;
    end
    % destModule --> destPos
    [obs_in_module,obs_out_module] = ModuleObstacle(destModule,0);
    optimalPath = VoronoiPathPlanning(destModulePos,destPos,obs_in_module,obs_out_module,d_thr_dest);
    optimalPath_short=[optimalPath(end,1),optimalPath(end,2),];
    endRow = endRow+length(optimalPath);
    PP(startRow:endRow,:)=optimalPath;
    path_select(end,:) = [startRow,endRow];
    PP_short(end,:)=optimalPath_short;
% Module Naviation is not needed (startModule == destModule)
else
    [obs_in_module,obs_out_module] = ModuleObstacle(startModule,0);
    PP=VoronoiPathPlanning(startPos,destPos,obs_in_module,obs_out_module,d_thr_dest);
    PP_short = [PP(1,:);PP(end,:)];
    path_select = [1,length(PP)];
end
%to be implemented if needed
PP_old=PP;
shift=0;
for i=1:length(PP_old)-1
    j=i+1;
    dr=norm(PP_old(j,:)-PP_old(i,:));
    if dr > d_thr_dest
       points = (round(dr/d_thr_dest)+1);
       PP_int=NodeInterpolation(PP_old(i,:),PP_old(j,:),points);
       PP=[PP(1:i-1+shift,:);PP_int;PP(j+1+shift:end,:)];
       shift=shift+length(PP_int)-2;
    end
end
end

