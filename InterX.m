%% Search the intersection of a FP with the sector boundaries
    % INPUT: Modified = [x1 x2; y1 y2]
    % OUTPUT: intersections = [Xbottom Xtop Yright Yleft]
    
function intersections = InterX(Modified)

    % Linear equation: y = ax + b
    a = (Modified(2,2)-Modified(2,1))/(Modified(1,2)-Modified(1,1));
    b = Modified(2,1) - a*Modified(1,1);

    if a == 0 % horizontal line
        intersectionXtop = -100;
        intersectionXbottom = -100;
        if Modified(1,1) < Modified(1,2) % direction: left --> right
            intersectionYright = Modified(2,2);
            intersectionYleft = -100;
        else  % direction: rigth --> left
            intersectionYright = -100;
            intersectionYleft = Modified(2,2);
        end
    elseif a == Inf % vertical line
        intersectionYright = -100;
        intersectionYleft = -100;
        if Modified(2,1) < Modified(2,2) % direction: bottom --> top
            intersectionXtop = Modified(1,2);
            intersectionXbottom = -100;
        else  % direction: top --> bottom
            intersectionXtop = -100;
            intersectionXbottom = Modified(1,2);
        end
    else % sloping line 
        intersectionYright = fix(a*100+b);
        intersectionYleft = fix(b);
        intersectionXtop = fix((100-b)/a);
        intersectionXbottom = fix(-b/a);
    end

    intersections = [intersectionXbottom intersectionXtop intersectionYright intersectionYleft];
    
end
