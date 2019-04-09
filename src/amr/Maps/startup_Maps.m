disp('Maps dir has succesfully been loaded !')

pathmap = fileparts( mfilename('fullpath') );

floor0path = fullfile(pathmap, 'floor0');
if exist(floor0path,'dir')
    addpath(floor0path);
end

floor0bispath = fullfile(pathmap, 'floor0bis');
if exist(floor0bispath,'dir')
    addpath(floor0bispath);
end

floor1path = fullfile(pathmap, 'floor1');
if exist(floor1path,'dir')
    addpath(floor1path);
end

floor2path = fullfile(pathmap, 'floor2');
if exist(floor2path,'dir')
    addpath(floor2path);
end

floor3path = fullfile(pathmap, 'floor3');
if exist(floor3path,'dir')
    addpath(floor3path);
end

clear pathmap floor0path floor0bispath floor1path floor2path floor3path