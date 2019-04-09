function angle = fullAngleDeg(angle)
%angle = fullAngle(angle)
% This function will spread an arbitrary angle in [1°,360°]
n=numel(angle);
for i=1:n
    
    if abs(angle(i))>=360      % Angle ofverflow check
        angle(i) =rem(angle(i),360);
    end
    
    if angle(i)<1
        angle(i)=360+angle(i);
    end
    
    if angle(i)>360
        angle(i) = angle(i) -360;       
    end
end
end