%% Count the number of affected aircraft

function numAffected = GetAffected(listFPi, listFPm,numFP)
    
    numAffected=0;
    nFP=1;
    while(nFP<=numFP)
        initialFP=listFPi(nFP,:);
        modifiedFP=listFPm(nFP,:);
        if (initialFP (3)~=modifiedFP(3) | initialFP(4)~=modifiedFP(4)|initialFP(5)~=modifiedFP(5))
            numAffected=numAffected+1;
        end
        nFP=nFP+1;
    end

end

