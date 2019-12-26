%% Computes the fitness of an individual

function fit = fitness(Affected,Conflicts, velocity_changes,heading_changes,distance_changes,numInd,numFP)
    
    % A + B + C + D = 1 --> Give weight to each one of the terms in the
                            % fitness function:
    A=0.25; % weight of the number of affected aircrafts
    B=0.25; % weight of the changes on velocity
    C=0.25; % weight of the changes on heading
    D=0.25; % weight of the difference in distance inside the sector
    sumVel = 0;
    sumAng = 0;
    sumDist = 0;
    %Computing the sum of velocity, heading and distance changes
    for i=1:1:numFP
        sumVel= sumVel+abs(velocity_changes(i));
        sumAng= sumAng+abs(heading_changes(i));
        sumDist= sumDist+abs(distance_changes(i));
    end

    %Fitness function
    if Conflicts <=3
        fit=(A*Affected)+(B*sumVel/numInd)+(C*sumAng/numInd)+(D*sumDist/numInd);
    else
        fit=inf;
    end
    
end

