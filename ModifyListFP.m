function ListFPm = ModifyListFP(ListFPi,numInd,ang,vel)

    ListFPm=zeros(numInd,numInd);
    
    IndCount=1;
    while(IndCount<=numInd)
        
        ListFPm(IndCount,:) = ModifyFP(ListFPi(IndCount,:), ang, vel);
        
        IndCount=IndCount+1;
    end
    
end

