function Matriz_poblacion = PoblacionInicial(Nvuelos,Poblacion)
    i=1;
    Matriz_poblacion=zeros(Poblacion,Nvuelos*5);
    while i<=Poblacion
         Matriz_poblacion(i,:)=randi([0,1],1,Nvuelos*5);
         i=i+1;
    end
end

