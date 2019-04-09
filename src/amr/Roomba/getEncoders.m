function [LeftEncoderCount,RightEncoderCount] = getEncoders(serPort)
% [AngleRAD] = AngleSensorRoomba(serPort)
% Displays the angle in radians that Roomba has turned since the angle was last requested.
% Counter-clockwise angles are positive and Clockwise angles are negative.
% parameters

%Initialize preliminary return values
LeftEncoderCount = nan;
RightEncoderCount = nan;
try

warning off
global td 
warning on

fwrite(serPort, [149,2,43,44]); % query list, #packets, leftEncoder, rightEncoders

LeftEncoderCount = fread(serPort, 1, 'uint16');
RightEncoderCount = fread(serPort, 1, 'uint16');

pause(td)

catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end

