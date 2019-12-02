function Conflicto = Conflicto_2FP(DistanciaSeguridad,TiempoSimulacion,FP1,FP2)
    Distancia1=sqrt(((FP1(3)-FP1(1))^2)+((FP1(4)-FP1(2))^2));
    Distancia2=sqrt(((FP2(3)-FP2(1))^2)+((FP2(4)-FP2(2))^2));
    At1=(Distancia1/FP1(5))*3600;
    At2=(Distancia2/FP2(5))*3600;
    if At1>At2
        At=At2;
    else
        At=At1;
    end
     D1=TiempoSimulacion*(FP1(5)/3600);
     D2=TiempoSimulacion*(FP2(5)/3600);
     Coseno1=(FP1(3)-FP1(1))/Distancia1;
     Coseno2=(FP2(3)-FP2(1))/Distancia2;
     Seno1=(FP1(4)-FP1(2))/Distancia1;
     Seno2=(FP2(4)-FP2(2))/Distancia2;
     X1=FP1(1);
     X2=FP2(1);
     Y1=FP1(2);
     Y2=FP2(2);
     Conflicto=false;
     
     Tiempo=TiempoSimulacion;
     while (Tiempo<=At && Conflicto==false)
      DistanciaEntreVuelos=sqrt(((X2-X1)^2) +((Y2-Y1)^2));
      if DistanciaEntreVuelos<=DistanciaSeguridad
          Conflicto=true;
      else
          X1=X1+(D1*Coseno1);
          X2=X2+(D2*Coseno2);
          Y1=Y1+(D1*Seno1);
          Y2=Y2+(D2*Seno2);
      end         
       Tiempo=Tiempo+TiempoSimulacion;
     end
end

