function intersections = InterX(Modified)
% Introduciendo las coordenadas modificadas de la siguiente manera:
% Modified = [x1 x2; y1 y2]
% la funcion "InterX" devuelve el vector "intersections" de la siguiente
% manera:
% intersections = [Xbottom Xtop Yright Yleft]
%Recta y = ax + b
a = (Modified(2,2)-Modified(2,1))/(Modified(1,2)-Modified(1,1));
b = Modified(2,1) - a*Modified(1,1);


syms x
syms y

Xtop = 0*x + 100;
Xbottom = 0*x;
Yleft = y*0;
Yright = y*0 + 100;

yMOD = a*x+b;
xMOD = (y-b)/a;
intersectionYright = fix(double(solve(xMOD==Yright,y)));
intersectionYleft = fix(double(solve(xMOD==Yleft,y)));
intersectionXtop = fix(double(solve(yMOD==Xtop,x)));
intersectionXbottom = fix(double(solve(yMOD==Xbottom,x)));

intersections = [intersectionXbottom intersectionXtop intersectionYright intersectionYleft];
end
