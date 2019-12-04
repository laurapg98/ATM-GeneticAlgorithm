%% Reads the file named fFP and returns the number of flight plans (numFP) it contains and the data of each os these flight plan in a matrix (listFP)

function [listFP ,numFP]= ReadFP(fFP)

    file=importdata(fFP);
    
    % columns: Xi, Yi, Xf, Yf, V
    % rows: one FP per row
    listFP=file.data;
    
    sizeF=size(file.data);
    numFP=sizeF(1);
    
end