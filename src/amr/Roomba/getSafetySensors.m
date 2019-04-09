function [Bump,Drop] = getSafetySensors(serPort)
%[BumpRight,BumpLeft,WheDropRight,WheDropLeft,WheDropCaster,BumpFront] = BumpsWheelDropsSensorsRoomba(serPort)
% Specifies the state of the bump and wheel drop sensors, either triggered
% or not triggered.

% By; Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
Bump=nan;
Drop=nan;

try

warning off
global td

fwrite(serPort, [142,7]);
BmpWheDrps = dec2bin(fread(serPort, 1),8);
BumpRight = bin2dec(BmpWheDrps(end));
BumpLeft = bin2dec(BmpWheDrps(end-1));
WheDropRight = bin2dec(BmpWheDrps(end-2));
WheDropLeft = bin2dec(BmpWheDrps(end-3));
WheDropCaster = bin2dec(BmpWheDrps(end-4));
BumpFront=(BumpRight*BumpLeft);
if BumpFront==1
    BumpRight =0;
    BumpLeft =0;
end

Bump=BumpFront||BumpRight||BumpLeft;
Drop=WheDropRight|| WheDropLeft || WheDropCaster;

pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end