function listaFP = LeerFP(fFP)

    % orden columnas: Xi, Yi, Xf, Yf, V
    
    fichero=importdata(fFP);
    
    listaFP=fichero.data;
    
end

