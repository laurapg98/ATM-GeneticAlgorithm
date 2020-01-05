%% Modifyes the population given a number of individuals that have to mutate

function mutatedPopulation = mutation(population, numInd, numMutated)
    
    mutatedPopulation=population;

    % individuals to mutate:
    mutInd=randi([1 numInd],1,numMutated);

    % mutate all FP of individuals that are in positions indicated in mutInd 
    for i=1:1:numMutated 
        for pos=1:1:numInd
            if(pos==mutInd(i)) % mutation
                for j=1:1:size(population,2)
                    if(population(pos,j)==0)
                        mutatedPopulation(pos,j)=1;
                    else
                        mutatedPopulation(pos,j)=0;
                    end
                end
            end
        end
    end

end

