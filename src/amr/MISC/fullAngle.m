function angle = fullAngle(angle)
%angle = fullAngle(angle)
% This function will spread an arbitrary angle in [0,2pi]

n=numel(angle);

for i=1:n
    if abs(angle(i))>=2*pi       % Angle ofverflow check
        angle(i) =rem(angle(i),2*pi);
    end
    
    if angle(i)<1
        angle(i)=2*pi+angle(i);
    end
    
    if angle(i)>2*pi
        angle(i) = angle(i) -2*pi;       
    end   
end
end