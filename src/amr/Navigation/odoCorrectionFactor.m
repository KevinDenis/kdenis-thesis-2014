function k = odoCorrectionFactor(incr)
%k = odoCorrectionFactor(incr)
%   Correction of the odometry receved from Roomba, in function of slope.

if     incr==  1
    k=1;
elseif incr== -1
    k=1;
elseif incr==  0
    k=1;
end

