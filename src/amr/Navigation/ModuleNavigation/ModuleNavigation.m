function [nextModule,moduleChange] = ModuleNavigation(robotPos, startModule, destModule, nextModule,d_thr_module)
% angle_R_nextNode, nextNode] = NodeNavigation(robotPos, xy_opt_path, nextNode)
% only use if nextModule ~= destModule
% TODO :
% * 
% DATA FORMAT :
% pos  : [x0 y0 th0]

%% Parameters
moduleChange = false;

%% Program
if isempty(nextModule)
    nextModule=startModule;
    moduleChange = true;
end

if nextModule ~= destModule
    if destModule>startModule
        disp('going up')
        increment  = 1;
    elseif destModule<startModule
        disp('going down')
        increment  = -1;
    else
        disp('same module')
        increment  = 0;
    end

    nextModulePos=Module2Pos(nextModule);

    dx = nextModulePos(1) - robotPos(1);
    dy = nextModulePos(2) - robotPos(2);   

    if sqrt(dx^2 + dy^2)  <= d_thr_module
        nextModule=nextModule+increment;
        moduleChange=true;
    end
else
    disp('already at dest module')
end

