function angles = plot_solution(ListFPi,ListFPm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Plotear el sector con los planes de vuelo
    x = linspace(0,100);
    y = linspace(0,100);
    % 
    Xtop = 0*x + 100;
    Xbottom = 0*x;
    Yleft = y*0;
    Yright = y*0 + 100;

    figure;
    axis equal
    plot(x,Xtop,'r',x,Xbottom,'r',Yleft,y,'r',Yright,y,'r','LineWidth',2)
    hold on
    ActualAngles = zeros(size(ListFPi,1),1);
    for pos = 1:1:size(ListFPi,1)
        plot([ListFPi(pos,1),ListFPi(pos,3)],[ListFPi(pos,2),ListFPi(pos,4)],'g');
        hold on
        plot([ListFPm(pos,1),ListFPm(pos,3)],[ListFPm(pos,2),ListFPm(pos,4)],'b');
        hold on
        plot([ListFPm(pos,1),ListFPm(pos,3)],[ListFPm(pos,2),ListFPm(pos,4)],'b*');
        hold on
        m2 = (ListFPm(pos,4)-ListFPm(pos,2))/(ListFPm(pos,3)-ListFPm(pos,1));
        m1 = (ListFPi(pos,4)-ListFPi(pos,2))/(ListFPi(pos,3)-ListFPi(pos,1));
        ActualAngles(pos,1) = atand((m2-m1)/(1+m2*m1));
    end
    
    angles = -1.*ActualAngles;
    
%     plot([Point_out(1)],[Point_out(2)],'b*')
    hold off
end

