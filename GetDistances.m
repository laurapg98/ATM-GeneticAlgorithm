%% Compute a matrix of the sum of distances (between the initial exit point and the current exit point) of all FP in a solution

function Distances = GetDistances(listFPi,listFPmod,numInd)
    
    Distances=zeros(numInd,1);
    
    FPcount=1;
    while(FPcount<=numInd)
        Distances(FPcount,1) = Distance_1FP(listFPi(FPcount,:),listFPm(FPcount,:));
        FPcount=FPcount+1;
    end

end

