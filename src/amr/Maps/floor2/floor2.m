function [obs_in,obs_out] = floor2()
%[obs_in,obs_out] = floor2()
%   Detailed explanation goes here
split=[NaN,NaN];
n=1;

obs_in_fl2_sprl=csvread('floor2_binnencirkel.csv');
obs_in_fl2_sprl=obs_in_fl2_sprl(:,1:2)/100;
obs_in_fl2_sprl=obs_in_fl2_sprl(1:n:end,:);
obs_in_fl2_sprl=[obs_in_fl2_sprl;obs_in_fl2_sprl(1,:);split];

obs_in=obs_in_fl2_sprl;

obs_out = csvread('floor2_buitenomtrek.csv');
obs_out=obs_out(:,1:2)/100;
obs_out=obs_out(1:n:end,:);
if obs_out(end,:) ~= obs_out(1,:)
    obs_out=[obs_out;obs_out(1,:)];
end
end

