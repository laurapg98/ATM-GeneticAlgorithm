%% Computes the fitness of an individual

function fit = fitness(Affected,Conflicts, velocity_changes,heading_changes,distance_changes,numInd,numFP)
    
    % A + B + C + D = 1 --> Gives weight to each one of the terms
    A=0.25; % weight of the number of affected aircrafts
    B=0.25; % weight of the changes on velocity
    C=0.25; % weight of the changes on heading
    D=0.25; % weight of the difference in distance inside the sector

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

