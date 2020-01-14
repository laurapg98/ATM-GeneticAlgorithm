%% Determines if there is or not a conflict between two flight plans

function Conflict = Conflict_2FP(SecDist,SimTime,FP1,FP2)

    Dist1=sqrt(((FP1(3)-FP1(1))^2)+((FP1(4)-FP1(2))^2));
    Dist2=sqrt(((FP2(3)-FP2(1))^2)+((FP2(4)-FP2(2))^2));
    At1=(Dist1/FP1(5))*3600;
    At2=(Dist2/FP2(5))*3600;
    if At1>At2
        At=At2;
    else
        At=At1;
    end
     D1=SimTime*(FP1(5)/3600);
     D2=SimTime*(FP2(5)/3600);
     Cos1=(FP1(3)-FP1(1))/Dist1;
     Cos2=(FP2(3)-FP2(1))/Dist2;
     Sin1=(FP1(4)-FP1(2))/Dist1;
     Sin2=(FP2(4)-FP2(2))/Dist2;
     X1=FP1(1);
     X2=FP2(1);
     Y1=FP1(2);
     Y2=FP2(2);
     Conflict=false;
     
     time=SimTime;
     while (time<=At && Conflict==false) % simulation
         DistFP=sqrt(((X2-X1)^2) +((Y2-Y1)^2));
         if DistFP<=SecDist
             Conflict=true;
         else
             X1=X1+(D1*Cos1);
             X2=X2+(D2*Cos2);
             Y1=Y1+(D1*Sin1);
             Y2=Y2+(D2*Sin2);
         end         
         time=time+SimTime;
     end
     
end