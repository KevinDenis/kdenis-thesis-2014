function modulePos = Module2Pos(moduleID)
% modulePos = Module2Pos(moduleID)
%   Small function, giving the entry position of each module.
%   parameters : 
%   moduleID  = int
%   modulePos = [x y]
%
%   firstColomnPos  = -1,3,7,11
%   secondColomnPos =  0,4,8,12
%   thridColomnPos  =  1,5,9,13
%   fourthColomnPos = 2,6,10,14

%% Parameters
firstColomnPos  = [30.60,31.00];
secondColomnPos = [30.81,18.60];
thridColomnPos  = [18.50,19.00];
fourthColomnPos = [18.50,31.00];

%% Finding position of module entrance 

shortModuleID = ShortModuleID(moduleID);
if      shortModuleID == -1
    modulePos = firstColomnPos;
elseif  shortModuleID ==  0
    modulePos = secondColomnPos;
elseif  shortModuleID ==  1
    modulePos = thridColomnPos;
elseif  shortModuleID ==  2
    modulePos = fourthColomnPos;
else
    disp('error, unexpected value in shortModuleID')
end

end
