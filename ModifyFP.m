%% Given an initial FP and the applied changes, modifies the FP

function [modifiedFP,dist] = ModifyFP(initialFP, ang, vel)
    ang = (+1)*ang;
    x1 = initialFP(1);
    x2 = initialFP(3);
    y1 = initialFP(2);
    y2 = initialFP(4);
    vel = initialFP(5) + vel;
    P1 = [x1 y1];
    P2 = [x2 y2];
    % Plotear el sector con los planes de vuelo
%     x = linspace(0,100);
%     y = linspace(0,100);
%     % 
%     Xtop = 0*x + 100;
%     Xbottom = 0*x;
%     Yleft = y*0;
%     Yright = y*0 + 100;
% 
%     figure;
%     axis equal
%     plot(x,Xtop,'r',x,Xbottom,'r',Yleft,y,'r',Yright,y,'r','LineWidth',2)
%     hold on
%     plot([P1(1),P2(1)],[P1(2),P2(2)],'g');
%     hold on
    
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

%     plot([P1(1),Xsrot],[P1(2),Ysrot],'c');
%     hold on
%     
%     modifiedFP = [P1(1),P1(2),Xsrot,Ysrot,vel];
    % Original = [x1 x2; y1 y2];
    % Modified = [x1 x2_new; y1 y2_new];
%     Original = [initialFP(1) initialFP(3); initialFP(2) initialFP(4)];
    Modified = [P1(1) Xsrot; P1(2) Ysrot];
    intersections = InterX(Modified);
    % intersections = [Xbottom Xtop Yright Yleft]
    Point_out = [0 0];
    % Condiciones de la interseccion:
    
    i = 1;
    while i <= length(intersections)
        % 1-Ha de estar comprendida dentro de los limites del sector
        if (intersections(i) < 100) && (intersections(i) > 0)
           % 2-No puede ser una de las coordenadas de inicio
            if i<=2
                if intersections(i) ~= P1(1) 
                    if intersections(i) ~= P1(1)+1
                        if intersections(i) ~= P1(1)-1
                            if i == 1 % Ha intersecado con el eje X inferior
                                Point_out = [intersections(i);0];
                            elseif i == 2% Ha intersecado con el eje X superior
                                Point_out = [intersections(i);100];
                            end
                        end
                    end
                end
            else
                if intersections(i) ~= P1(2) 
                    if intersections(i) ~= P1(2)+1 
                        if intersections(i) ~= P1(2)-1
                            if i == 3 % Ha intersecado con el eje Y derecho
                               Point_out = [100;intersections(i)];
                           elseif i == 4 % Ha intersecado con el eje Y izquierdo
                               Point_out = [0;intersections(i)];
                           end
                        end
                    end
                end
            end
        end
        i = i + 1;
    end
%     plot([Point_out(1)],[Point_out(2)],'b*')
%     hold on
    modifiedFP = [P1(1),P1(2),Point_out(1),Point_out(2),vel];
    dist = sqrt((Point_out(1)-P1(1))^2 + (Point_out(2)-P1(2))^2) - sqrt((P2(1)-P1(1))^2 + (P2(2)-P1(2))^2);
end

