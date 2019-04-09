function [obs_in,obs_out,map,rawRayData]=Map2Obs(currentMap)
%[obs_in,obs_out]=Map2Obs(currentMapID)
%   This function will load the next map data, beeing :
%   * obstacles of the map (in and out)
%   * rayData of the next map

global rawRayData0 rawRayData0b rawRayData1 rawRayData2 rawRayData3

if     currentMap == 1
    [obs_in,obs_out]=floor0_org();
    map=imread('floor0.png');
    rawRayData = rawRayData0;
elseif currentMap == 2
    [obs_in,obs_out]=floor0bis_org();
    map=imread('floor0bis.png');
    rawRayData = rawRayData0b;
elseif currentMap == 3
    [obs_in,obs_out]=floor1_org();
    map=imread('floor1.png');
    rawRayData = rawRayData1;   
elseif currentMap == 4
    [obs_in,obs_out]=floor2_org();
    map=imread('floor2.png');
	rawRayData = rawRayData2; 
elseif currentMap == 5
    [obs_in,obs_out]=floor3_org();
    map=imread('floor3.png');
    rawRayData = rawRayData3; 
end
    
end