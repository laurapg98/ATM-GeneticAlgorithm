function fit = fitness(Affected,Conflicts, velocity_changes,heading_changes,distance_changes,numInd,numFP)
    A=0.25;
    B=0.25;
    C=0.25;
    D=0.25;

    %Computing the sum of velocity, heading and distance changes
    for i=1:1:numFP
        sumVel= sumVel+velocity_changes(i);
        sumAng= sumAng+heading_changes(i);
        sumDist= sumDist+distance_changes(i);
    end

    %Fitness function
    if Conflicts <=3
        fit=(A*Affected)+(B*sumVel/numInd)+(C*sumAng/numInd)+(D*sumDist/numInd);
    else
        fit=inf;
    end
    
end

