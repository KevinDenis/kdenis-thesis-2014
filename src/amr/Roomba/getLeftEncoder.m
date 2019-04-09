function LeftEncoderCount = getLeftEncoder(serPort)
% [AngleRAD] = AngleSensorRoomba(serPort)
% Displays the angle in radians that Roomba has turned since the angle was last requested.
% Counter-clockwise angles are positive and Clockwise angles are negative.
% Magic number = x3

%Initialize preliminary return values
LeftEncoderCount = nan;

try

warning off
global td 
warning on

fwrite(serPort, [142,43]);

LeftEncoderCount = fread(serPort, 1, 'uint16');

pause(td)

catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end

