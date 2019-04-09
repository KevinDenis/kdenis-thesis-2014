function shortModuleID = ShortModuleID(moduleID)
%SHORTMODULEID Summary of this function goes here
%   Detailed explanation goes here

if isValidModule(moduleID)
    for i=0:3
        if (moduleID - 4*i) < 3 && (moduleID - 4*i > -2)
            shortModuleID = moduleID - 4*i;
        end
    end
end


end

