function angleDeg = shortestAngleDeg(angleDeg)
%angle = shortestAngle(angle)
% This function will spread an arbitrary angle in [-pi,pi]
n=numel(angleDeg);
for i=1:n
    if abs(angleDeg(i))>=360       % Angle ofverflow check
        angleDeg(i) =rem(angleDeg(i),360);
    end
    if angleDeg(i)>180
        angleDeg(i)=-360+angleDeg(i);  % Go reverse, negative sign convention
    elseif angleDeg(i)<-180
        angleDeg(i)=360+angleDeg(i);
    end
    
end
end