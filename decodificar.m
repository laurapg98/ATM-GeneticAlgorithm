%% cosa
function [vel,angle] = decodificar(bits) % da el cambio de velocidad y de ángulo dado un vector de bits (long=5)
    
    % 3 primeros bits --> velocidad
    if(bits(2)==0 && bits(3)==0)
        vel=0;
    end
    if(bits(2)==0 && bits(3)==1)
        vel=15;
    end
    if(bits(2)==1 && bits(3)==0)
        vel=30;
    end
    if(bits(2)==1 && bits(3)==1)
        vel=20;
    end
    if(bits(1)==1) % signo
        vel=-vel;
    end
    
    % 2 últimos bits --> cambio angulo
    if(bits(4)==1 && bits(5)==0)
        angle=-30; % izquierda
    elseif(bits(4)==0 && bits(5)==1)
        angle=+30; % derecha
    else
        angle=0;
    end
    
end

