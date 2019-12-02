function [listaFP ,Nvuelos]= LeerFP(fFP)

    % orden columnas: Xi, Yi, Xf, Yf, V
    
    fichero=importdata(fFP);
    
    listaFP=fichero.data;
    tamano=size(fichero.data);
    Nvuelos=tamano(1);
end

