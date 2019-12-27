%% Plot the sector with the initial and the final flight plans

function angles = plot_solution(ListFPi,ListFPm)
    x = linspace(0,100);
    y = linspace(0,100);
    
    Xtop = 0*x + 100;
    Xbottom = 0*x;
    Yleft = y*0;
    Yright = y*0 + 100;

    figure;
    axis([0 130 0 100])
    plot(x,Xtop,'r',x,Xbottom,'r',Yleft,y,'r',Yright,y,'r','LineWidth',2)
    text(105,100,'Green lines: Initial FP');
    text(105,90,'Blue lines: Final FP');
    text(105,80,'Blue points: Final entry & exit points');
    hold on
    ActualAngles = zeros(size(ListFPi,1),1);
    for pos = 1:1:size(ListFPi,1)
        plot([ListFPi(pos,1),ListFPi(pos,3)],[ListFPi(pos,2),ListFPi(pos,4)],'g'); % initial FP
        hold on
        plot([ListFPm(pos,1),ListFPm(pos,3)],[ListFPm(pos,2),ListFPm(pos,4)],'b'); % final FP
        hold on
        plot([ListFPm(pos,1),ListFPm(pos,3)],[ListFPm(pos,2),ListFPm(pos,4)],'b*'); % final entry & exit points
        hold on
        m2 = (ListFPm(pos,4)-ListFPm(pos,2))/(ListFPm(pos,3)-ListFPm(pos,1));
        m1 = (ListFPi(pos,4)-ListFPi(pos,2))/(ListFPi(pos,3)-ListFPi(pos,1));
        ActualAngles(pos,1) = atand((m2-m1)/(1+m2*m1));
    end
    
    angles = -1.*ActualAngles;
    
end

