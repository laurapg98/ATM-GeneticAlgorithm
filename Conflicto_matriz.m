function [Conflictos,listaFPcambiada,cambios] = Conflicto_matriz(Matriz_poblacion,listaFP,DistanciaSeguridad,TiempoSimulacion)

    sizeP=size(Matriz_poblacion); % tamaño de la Matriz_poblacion (primera posición en vertical (num filas), segunda en horizontal (num columnas))
    
    Conflictos=zeros(sizeP(1),1); % guarda el número de conflictos que tiene cada solución
    
    % separamos en cromosomas
    chrom=1; % recorre la matriz en vertical
    while(chrom<sizeP(1))
        cromosoma=Matriz_poblacion(chrom,:);
        
        % separamos en FP
        FP=zeros(sizeP(1),5);
        FPcont=1;
        while(FPcont<=sizeP(2))
            
            % cogemos 5 bits de cada FP
            bit=1;
            while(bit<=5)
                FP(FPcont,bit)=cromosoma((5*(FPcont-1))+bit);
                bit=bit+1;
            end
            
            FPcont=FPcont+5;
        end
        
        % decodificamos y modificamos la lista de FP
        listaFPcambiada=zeros(sizeP(2),5);
        cambios=zeros(sizeP(2),2);
        FPcont=1;
        while(FPcont<=sizeP(2))
            [vel,ang] = decodificar(FP(FPcont,:));
            listaFPcambiada(FPcont,:) = CambiosFP(listaFP(FPcont,:), ang, vel);
            cambios(FPcont,:)=[vel,ang];
            FPcont=FPcont+1;
        end
        
        % miramos conflictos
        FPcont=1;
        while(FPcont<sizeP(2))
            FP1=listaFPcambiada(FPcont,:);
            i=FPcont+1;
            while(i<=sizeP(2))
                FP2=listaFPcambiada(i,:);
                if(Conflicto_2FP(DistanciaSeguridad,TiempoSimulacion,FP1,FP2)==true)
                    Nconflictos=Nconflictos+1;
                end
                i=i+1;
            end
            FPcont=FPcont+1;
        end
        
        % guardamos Nconflictos
        Conflictos(chrom,1)=Nconflictos;
        
        chrom=chrom+1;
    end
    
end

