%% Plot the sector with the initial and the final flight plans

function angles = plot_solution(ListFPi,ListFPm)
    x = linspace(0,100);
    y = linspace(0,100);
    
    Xtop = 0*x + 100;
    Xbottom = 0*x;
    Yleft = y*0;
    Yright = y*0 + 100;

    figure;
%     axis([0 300 0 100])
    axis equal
    plot(x,Xtop,'r',x,Xbottom,'r',Yleft,y,'r',Yright,y,'r','LineWidth',2)
%     text(105,100,'Green lines: Initial FP');
%     text(105,90,'Blue lines: Final FP');
%     text(105,80,'Blue points: Final entry & exit points');
%     dim = [x y w h];
    
    
    
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
    hold off
    
    angles = -1.*ActualAngles;
    figure
    dim = [.2 .6 .2 .2];
    annotation('textbox',dim,'String','Green lines: Initial flight plan','FitBoxToText','on');
    dim = [.2 .5 .2 .2];
    annotation('textbox',dim,'String','Blue lines: Final flight plan','FitBoxToText','on');
    dim = [.2 .4 .2 .2];
    annotation('textbox',dim,'String','Blue asterisks: Final entry & exit points','FitBoxToText','on');
    
end

