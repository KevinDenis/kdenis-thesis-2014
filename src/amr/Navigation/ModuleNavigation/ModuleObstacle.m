function [obs_in_module,obs_out_module] = ModuleObstacle(ModuleID, incr)
%[obs_in_module,obs_out_module] = ModuleObstacle(ModuleID)
%   
%
%   floor & modules info
%
%   Static
%   floor0 : ModulesID :-1, 0, 1, 2
%   floor1 : ModulesID : 3, 4, 5, 6 
%   floor2 : ModulesID : 7, 8, 9,10     
%   floor3 : ModulesID :11,12,13,14
%
%   Going up
%   floor0 : ModulesID :-1, 0, 1
%   floor1 : ModulesID : 2, 3, 4, 5 
%   floor2 : ModulesID : 6, 7, 8, 9     
%   floor3 : ModulesID :10;11,12,13,14
%   
%   Going down
%   floor0 : ModulesID :-1, 0, 1, 2
%   floor1 : ModulesID : 3, 4, 5, 6,7 
%   floor2 : ModulesID : 8, 9,10,11     
%   floor3 : ModulesID :12,13,14

%% Parameters
if incr > 0
    if                     ModuleID < 2
        [obs_in_module,obs_out_module] = floor0();
    elseif ModuleID > 1 && ModuleID < 6
        [obs_in_module,obs_out_module] = floor1();
    elseif ModuleID > 5 && ModuleID < 10
        [obs_in_module,obs_out_module] = floor2();
    elseif ModuleID > 9 
        [obs_in_module,obs_out_module] = floor3();
    end
elseif incr < 0 
    if                     ModuleID < 3
        [obs_in_module,obs_out_module] = floor0();
    elseif ModuleID > 2 && ModuleID < 8
        [obs_in_module,obs_out_module] = floor1();
    elseif ModuleID > 7 && ModuleID < 12
        [obs_in_module,obs_out_module] = floor2();
    elseif ModuleID > 11 
        [obs_in_module,obs_out_module] = floor3();
    end
else
    if                     ModuleID < 3
        [obs_in_module,obs_out_module] = floor0();
    elseif ModuleID > 2 && ModuleID < 7
        [obs_in_module,obs_out_module] = floor1();
    elseif ModuleID > 6 && ModuleID < 11
        [obs_in_module,obs_out_module] = floor2();
    elseif ModuleID > 10 
        [obs_in_module,obs_out_module] = floor3(); 
    end
end
end
