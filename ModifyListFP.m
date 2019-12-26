%% modifies each FP on one individual
    % receives the initial FP of all the individual, the number of flight
    % plans of each individual and the bits vector that modifies the FPs

function [ListFPm, AllVel,AllAngles,AllDist] = ModifyListFP(ListFPi,numFP,IndBits)

    ListFPm=zeros(numFP,5);
    AllVel=[];
    AllAngles=[];
    AllDist =[];
    FPCount=1;
    while(FPCount<=numFP) % Modifiees each FP
        bitsFP=[];
        for i=1:1:6
            bitsFP=[bitsFP IndBits(6*(FPCount-1)+i)];
        end
        [vel,ang] = DecodeBits(bitsFP);
        [ListFPm(FPCount,:),dist] = ModifyFP(ListFPi(FPCount,:), ang, vel);
        AllVel=[AllVel vel];
        AllAngles=[AllAngles ang];
        AllDist=[AllDist dist];
        FPCount=FPCount+1;
    end
    
end

