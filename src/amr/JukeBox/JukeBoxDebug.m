clear all
close all
clc

startup_JB

JB_flag=1;
GPP_length=10;

for i=1:GPP_length
    nextNode=i;
    JB_flag=JukeBox(JB_flag,nextNode,GPP_length);
    pause(2)
end
JB_flag=JukeBox(7,nextNode,GPP_length);