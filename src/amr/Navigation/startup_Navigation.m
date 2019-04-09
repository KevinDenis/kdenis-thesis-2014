disp('Navigation dir has succesfully been loaded !');

pathnav = fileparts( mfilename('fullpath') );

modulepath = fullfile(pathnav, 'ModuleNavigation');
if exist(modulepath,'dir')
    addpath(modulepath);
end

nodepath = fullfile(pathnav, 'NodeNavigation');
if exist(nodepath,'dir')
    addpath(nodepath);
end

dwapath = fullfile(pathnav, 'DWA');
if exist(dwapath,'dir')
    addpath(dwapath);
end

clear pathnav modulepath nodepath dwapath