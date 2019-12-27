%% Given an initial FP and the applied changes, modifies the FP

function [modifiedFP,dist] = ModifyFP(initialFP, ang, vel)

    % Initial FP entry & exit points
    x1 = initialFP(1);
    x2 = initialFP(3);
    y1 = initialFP(2);
    y2 = initialFP(4);
    P1 = [x1 y1]; % entry point
    P2 = [x2 y2]; % exit point
   
    % Center of rotation
    Xc = P1(1);
    Yc = P1(2);
    
    % Shift X/Y to the rotation center
    Xshift = P2(1)-Xc;
    Yshift = P2(2)-Yc;
    
    % Rotate the coordinates
    Xsrot =  Xshift*cosd(ang) + Yshift*sind(ang);
    Ysrot = -Xshift*sind(ang) + Yshift*cosd(ang);
    
    % Shift the rotated coordinates back to the original reference center
    Xsrot = Xsrot + Xc;
    Ysrot = Ysrot + Yc;

    % Compute intersections = [Xbottom Xtop Yright Yleft]
    intersections = InterX([P1(1) Xsrot; P1(2) Ysrot]);
    
    % Compute the exit point
    Point_out=[0 0];
    %Point_out = [];
    i = 1;
    while i <= length(intersections)
        % 1.- It shall be inside the sector boundaries
        if (intersections(i) < 100) && (intersections(i) > 0)
            % 2.- It can be one of the initial coordinates
            if i<=2 % intersection with X axis
                if intersections(i) ~= P1(1) && intersections(i) ~= P1(1)+1 && intersections(i) ~= P1(1)-1
%                     if intersections(i) ~= P1(1)+1
%                         if intersections(i) ~= P1(1)-1
                            if i == 1 % Intersection with Xbottom
                                Point_out = [intersections(i);0];
                            elseif i == 2 % Intersection with Xtop
                                Point_out = [intersections(i);100];
                            end
%                         end
%                     end
                end
            else % intersection with Y axis
                if intersections(i) ~= P1(2) && intersections(i) ~= P1(2)+1 && intersections(i) ~= P1(2)-1
%                     if intersections(i) ~= P1(2)+1 
%                         if intersections(i) ~= P1(2)-1
                            if i == 3 % Intersection with Yrigth
                               Point_out = [100;intersections(i)];
                           elseif i == 4 % Intersection with Yleft
                               Point_out = [0;intersections(i)];
                           end
%                         end
%                     end
                end
            end
        end
        i = i + 1;
    end
    
    
    modifiedFP = [P1(1),P1(2),Point_out(1),Point_out(2),vel];
    dist = sqrt((Point_out(1)-P1(1))^2 + (Point_out(2)-P1(2))^2) - sqrt((P2(1)-P1(1))^2 + (P2(2)-P1(2))^2);
end

