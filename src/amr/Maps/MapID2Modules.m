function [col1,col2,col3,col4] = MapID2Modules(currentMapID)
%MAPID2MODULES Summary of this function goes here
%   Detailed explanation goes here
if     currentMapID == 1
    str1= num2str(-1);
    str2= num2str(0);
    str3= num2str(1);
    str4= num2str(2);
elseif currentMapID == 2
    str1= num2str(3);
    str2= num2str(0);
    str3= num2str(1);
    str4= num2str(2);
elseif currentMapID == 3
    str1= num2str(3);
    str2= num2str(4);
    str3= num2str(5);
    str4= num2str(6);
elseif currentMapID == 4
    str1= num2str(7);
    str2= num2str(8);
    str3= num2str(9);
    str4= num2str(10);
elseif currentMapID == 5
    str1= num2str(11);
    str2= num2str(12);
    str3= num2str(13);
    str4= num2str(14);
end

col1=text(35,37.5,['module ',str1]);
col1.FontSize=15;
col2=text(35,10,['module ',str2]);
col2.FontSize=15;
col3=text(10,10,['module ',str3]);
col3.FontSize=15;
col4=text(10,37.5,['module ',str4]);
col4.FontSize=15;

end

