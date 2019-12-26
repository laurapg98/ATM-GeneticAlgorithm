function intersections = InterX(Modified)
% Introduciendo las coordenadas modificadas de la siguiente manera:
% Modified = [x1 x2; y1 y2]
% la funcion "InterX" devuelve el vector "intersections" de la siguiente
% manera:
% intersections = [Xbottom Xtop Yright Yleft]
%Recta y = ax + b
a = (Modified(2,2)-Modified(2,1))/(Modified(1,2)-Modified(1,1));
b = Modified(2,1) - a*Modified(1,1);


% syms x y
% 
% Xtop = 0*x + 100;
% Xbottom = 0*x;
% Yleft = y*0;
% Yright = y*0 + 100;
% 
% yMOD = a*x+b;
% xMOD = (y-b)/a;
% 
% if a == 0
%     intersectionXtop = -100;
%     intersectionXbottom = -100;
%     if Modified(1,1)<Modified(1,2)
%         intersectionYright = Modified(2,2);
%         intersectionYleft = -100;
%     else
%         intersectionYright = -100;
%         intersectionYleft = Modified(2,2);
%     end
% elseif a == Inf
%     intersectionYright = -100;
%     intersectionYleft = -100;
%     if Modified(2,1)<Modified(2,2)
%         intersectionXtop = Modified(1,2);
%         intersectionXbottom = -100;
%     else
%         intersectionXtop = -100;
%         intersectionXbottom = Modified(1,2);
%     end
% else
%     intersectionYright = fix(double(solve(xMOD==Yright,y)));
%     intersectionYleft = fix(double(solve(xMOD==Yleft,y)));
%     intersectionXtop = fix(double(solve(yMOD==Xtop,x)));
%     intersectionXbottom = fix(double(solve(yMOD==Xbottom,x)));
% end

if a == 0
    intersectionXtop = -100;
    intersectionXbottom = -100;
    if Modified(1,1)<Modified(1,2)
        intersectionYright = Modified(2,2);
        intersectionYleft = -100;
    else
        intersectionYright = -100;
        intersectionYleft = Modified(2,2);
    end
elseif a == Inf
    intersectionYright = -100;
    intersectionYleft = -100;
    if Modified(2,1)<Modified(2,2)
        intersectionXtop = Modified(1,2);
        intersectionXbottom = -100;
    else
        intersectionXtop = -100;
        intersectionXbottom = Modified(1,2);
    end
else
    intersectionYright = fix(a*100+b);
    intersectionYleft = fix(b);
    intersectionXtop = fix((100-b)/a);
    intersectionXbottom = fix(-b/a);
end

intersections = [intersectionXbottom intersectionXtop intersectionYright intersectionYleft];
end
