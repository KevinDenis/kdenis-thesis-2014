jbpath = fileparts( mfilename('fullpath') );
soundpath = fullfile(jbpath, 'sounds');
if exist(soundpath,'dir')
    addpath(soundpath);
end

load('start_data.mat');
load('quarter_data.mat');
load('half_data.mat');
load('near_data.mat');
load('arrived_data.mat');
load('easteregg_data.mat');
warning off
global start_data quarter_data half_data near_data arrived_data easteregg_data
warning on
clear soundpath jbpath