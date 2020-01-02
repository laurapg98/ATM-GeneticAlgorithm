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
Pm=0.01; % Probability of mutation
numMutated=Pm*numInd; % # individuals that have to mutate

repetitions = 1;
continuesimulation=true;
equalresults=0;
while(continuesimulation==true)

    % FITNESS
    FitnessVector=zeros(numInd,1);
    for Chrom=1:1:numInd 
        [ListFPm,AllVel,AllAng,AllDist] = ModifyListFP(ListFPi,numFP,population(Chrom,:)); % Modifies each flight plan according to each solution (individual) 
        numAffected = GetAffected(ListFPi, ListFPm,numFP); % computes the number of affected aircrafts
        numConflicts = GetConflicts(ListFPm,SecDistance,SimTime,numFP); % computes the number of conflicts between FPs
        FitnessVector(Chrom) = fitness(numAffected,numConflicts, AllVel,AllAng,AllDist,numInd,numFP); % computes the fitness of each individual of the population
    end
    FitnessVector_Sorted=sort(FitnessVector); % fitness values sorted (minimum first)
    FitnessVectorSorted_new = index_sort(FitnessVector,FitnessVector_Sorted); % fitness value sorted and index of this solution in population matrix
    
    % NEW POPULATION
    Elitism = FitnessVectorSorted_new(1:numElitism,:); 
    NoElitism = FitnessVectorSorted_new(numElitism+1:end,:);
    populationNEW = zeros(size(population,1),size(population,2));
    populationNEW(1:numElitism,:) = population(Elitism(:,2),:); % elitist solutions copied
    newNoElitism = NoElitism;
    newPopulationIndex = 11;
    for u = 1:1:numNoElitism/2
        choice = RouletteWheel(newNoElitism); % random choice 1 
        solution_1 = population(newNoElitism(choice,2),:);
        choice = RouletteWheel(newNoElitism); % random choice 2
        solution_2 = population(newNoElitism(choice,2),:);
        [solution_jr_1,solution_jr_2] = crossover(solution_1,solution_2); % CROSSOVER
        populationNEW(newPopulationIndex,:) = solution_jr_1;
        populationNEW(newPopulationIndex+1,:) = solution_jr_2;
        newPopulationIndex = newPopulationIndex + 2;

    end
    mutatedPopulation = mutation(populationNEW, numInd, numMutated); % MUTATION
    
    solutions(1,repetitions) = FitnessVector_Sorted(1,1);
    
    if(repetitions>1 && solutions(1,repetitions-1)==solutions(1,repetitions)) %The loop must finish when the lasts 25 values of vector "solution" are the same ones
        equalresults=equalresults+1;
    else
        equalresults=0;
    end
    
    if(equalresults>=100)
        index_best=FitnessVectorSorted_new(1,2);
        [ListFPm_best,~,~,~] = ModifyListFP(ListFPi,numFP,population(index_best,:));
        numAffected = GetAffected(ListFPi, ListFPm_best,numFP);
        numConflicts = GetConflicts(ListFPm_best,SecDistance,SimTime,numFP);
        BestAffectedConflict(repetitions,1) = numAffected;
        BestAffectedConflict(repetitions,2) = numConflicts;
        
        continuesimulation=false;
    else
        index_best=FitnessVectorSorted_new(1,2);
        [ListFPm_best,~,~,~] = ModifyListFP(ListFPi,numFP,population(index_best,:));
        numAffected = GetAffected(ListFPi, ListFPm_best,numFP);
        numConflicts = GetConflicts(ListFPm_best,SecDistance,SimTime,numFP);
        BestAffectedConflict(repetitions,1) = numAffected;
        BestAffectedConflict(repetitions,2) = numConflicts;
        repetitions=repetitions+1
        population=mutatedPopulation;
    end
    
end



%% SECTION 5: results
figure('NumberTitle', 'off', 'Name', 'Best solution per iteration');
x = 1:1:repetitions;
plot(x,solutions)

figure('NumberTitle', 'off', 'Name', 'Number of conflicts & affected flights per iteration');
plot(x,BestAffectedConflict(:,1))
hold on
plot(x,BestAffectedConflict(:,2))
legend('Number of affected flights','Number of conflicts')
hold off

index_best=FitnessVectorSorted_new(1,2);

[ListFPm_best,AllVel,AllAng,AllDist] = ModifyListFP(ListFPi,numFP,population(index_best,:));
numAffected = GetAffected(ListFPi, ListFPm_best,numFP)
numConflicts = GetConflicts(ListFPm_best,SecDistance,SimTime,numFP)
angles = plot_solution(ListFPi,ListFPm_best);












