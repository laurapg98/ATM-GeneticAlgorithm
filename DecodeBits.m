%% Returns the speed and heading changes of a certain FP, given the bits

function [vel,angle] = DecodeBits(bits)
    
    % speed
    if(bits(2)==0 && bits(3)==0)
        vel=0;
    end
    if(bits(2)==0 && bits(3)==1)
        vel=15;
    end
    if(bits(2)==1 && bits(3)==0)
        vel=30;
    end
    if(bits(2)==1 && bits(3)==1)
        vel=20;
    end
    if(bits(1)==1) % negative
        vel=-vel;
    end
    
    % heading
    if(bits(4)==1 && bits(5)==0)
        angle=-30; % left
    elseif(bits(4)==0 && bits(5)==1)
        angle=+30; % right
    else
        angle=0;
    end
    
end

