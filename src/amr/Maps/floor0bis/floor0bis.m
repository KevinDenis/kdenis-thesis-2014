function [obs_in,obs_out] = floor0bis()
%[obs_in,obs_out] = floor0bis()
%   Detailed explanation goes here
n=1;
obs_in=[];
obs_out = csvread('floor0bis_buitenomtrek.csv');
obs_out=obs_out(1:n:end,:);
obs_out=obs_out(:,1:2)/100;
obs_out=[obs_out;obs_out(1,:)];
end

