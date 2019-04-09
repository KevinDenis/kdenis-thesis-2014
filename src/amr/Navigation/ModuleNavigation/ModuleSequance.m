function [modules, incr] = ModuleSequance(startModule,destModule)
%modules = ModuleSequance(startModule,destModule)
%   Detailed explanation goes here
if destModule>startModule
    incr  = 1;
    disp('going up')
elseif destModule<startModule
    disp('going down')
    incr  = -1;
else
    disp('same module')
    incr  = 0;
    modules=[startModule,destModule];
end

if incr~=0
    modules=(startModule:incr:destModule)';
end

end

