function valid = isValidModule( moduleID )
%valid = isValidModule( moduleID )
%   Small function, checking the validity of a given module :
%   Modules should be between -1 and 14

if moduleID > 14 || moduleID < -1
    disp('error, unexpexted module given')
    disp('moduleID should be bewteen -1 and 14')
    valid = false;
elseif round(moduleID) ~= moduleID
    disp('error, unexpexted module given')
    disp('moduleID should be an integer value')
    valid = false;
else
    valid = true;
end

