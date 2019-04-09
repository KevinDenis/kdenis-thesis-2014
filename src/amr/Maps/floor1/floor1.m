function [obs_in,obs_out] = floor1()
%[obs_in,obs_out] = floor1()
%   Detailed explanation goes here
split=[NaN,NaN];
n=5;

obs_in_fl1_sprl=csvread('floor1_binnenomtrek.csv');
obs_in_fl1_sprl=obs_in_fl1_sprl(:,1:2)/100;
obs_in_fl1_sprl=obs_in_fl1_sprl(1:n:end,:);
obs_in_fl1_sprl=[obs_in_fl1_sprl;obs_in_fl1_sprl(1,:);split];

obs_in=obs_in_fl1_sprl;
obs_out = csvread('floor1_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=obs_out(1:n:end,:);
obs_out=[obs_out;obs_out(1,:)];

end

