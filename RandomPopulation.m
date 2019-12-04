%% Generates a population of numInd solutions, where each one of them with numFP flight plans and each FP coded with numBits bits

function population = RandomPopulation(numFP,numInd,numBits)
    i=1;
    population=zeros(numInd,numFP*numBits);
    while i<=numInd
         population(i,:)=randi([0,1],1,numFP*numBits);
         i=i+1;
    end
end