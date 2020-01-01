%% SECTION 1: clean MATLAB

clc
clear all
close all


%% SECTION 2: read airspace from files (sector + flight plans)

% fSector="sector"; % data file of sector     ---> NO EXISTE
% LeerSector(fSector); %      ---> TAMPOCO EXISTE

% fFP="FlightPlans.txt"; % data file of flight plans
fFP="test.txt";
[ListFPi,numFP]=ReadFP(fFP); 


%% SECTION 3: create initial population

numInd=100; % # individuals(=chromosomas=solutions)
numBits=6; % # bits per FP (about our codification)

population = RandomPopulation(numFP,numInd,numBits);


%% SECTION 4: GA loop

SecDistance=8; % security distance in NM
SimTime=5; % time increment in seconds
PercetageElitism=0.1;
numElitism=PercetageElitism*numInd; % # individuals copied in the new population
numNoElitism=numInd-numElitism; % # individuals that have to enter in the roulette
Pm=0.02; % Probability of mutation
numMutated=Pm*numInd; % # individuals that have to mutate
repetitions = 1;
while(repetitions<=100)

    % FITNESS
    FitnessVector=zeros(numInd,1);
    for Chrom=1:1:numInd % computes the fitness of each individual of the population
        [ListFPm,AllVel,AllAng,AllDist] = ModifyListFP(ListFPi,numFP,population(Chrom,:)); % Modifies each flight plan according to each solution (individual) 
        numAffected = GetAffected(ListFPi, ListFPm,numFP);
        numConflicts = GetConflicts(ListFPm,SecDistance,SimTime,numFP);
        FitnessVector(Chrom) = fitness(numAffected,numConflicts, AllVel,AllAng,AllDist,numInd,numFP);
    end
    FitnessVector_Sorted=sort(FitnessVector);
%   Returns the fitness vector sorted and with the index of the solution of
%   the vector fitness vector
    FitnessVectorSorted_new = index_sort(FitnessVector,FitnessVector_Sorted);
    Elitism = FitnessVectorSorted_new(1:numElitism,:);
    NoElitism = FitnessVectorSorted_new(numElitism+1:end,:);
    populationNEW = zeros(size(population,1),size(population,2));

    populationNEW(1:numElitism,:) = population(Elitism(:,2),:);
    newNoElitism = NoElitism;
    newPopulationIndex = 11;
    for u = 1:1:numNoElitism/2
        choice = RouletteWheel(newNoElitism);
        solution_1 = population(newNoElitism(choice,2),:);
        choice = RouletteWheel(newNoElitism);
        solution_2 = population(newNoElitism(choice,2),:);
        % CROSSOVER
        [solution_jr_1,solution_jr_2] = crossover(solution_1,solution_2);



        populationNEW(newPopulationIndex,:) = solution_jr_1;
        populationNEW(newPopulationIndex+1,:) = solution_jr_2;
        newPopulationIndex = newPopulationIndex + 2;

    end
    % MUTATION
    mutatedPopulation = mutation(populationNEW, numInd, numMutated);

    population=mutatedPopulation;
    solutions(1,repetitions) = FitnessVector_Sorted(1,1);
    if repetitions>=21 && solutions(repetitions)==solutions(repetitions-20) %The loop must finish when the lasts 25 values of vector "solution" are the same ones
        break
    else
    repetitions = repetitions + 1;
    end
    repetitions
   

end



%% SECTION 5: results
figure;
x = 1:1:repetitions;
plot(x,solutions)
% angles = plot_solution(ListFPi,ListFPm)    