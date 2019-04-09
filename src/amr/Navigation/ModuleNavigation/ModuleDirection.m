function incr = ModuleDirection(startModule,destModule,currentModule)
%incr = ModuleDirection(startModule,destModule,currentModule)
%   Small function, evaluating of the AMR is going up, down, or is arrived
%   at its destination module : nececery for map chaning

if currentModule ~= destModule
    if destModule>startModule
        incr  = 1;
    elseif destModule<startModule
        incr  = -1;
    else
        incr  = 0;
    end
else
    incr = 0;
end
end

