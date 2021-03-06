%% SECTION 1: clean MATLAB

clc
clear all
close all


%% SECTION 2: read airspace from files (flight plans)

fFP="FlightPlans.txt"; % data file of flight plans
[ListFPi,numFP]=ReadFP(fFP); 


%% SECTION 3: create initial population

numInd=100; % # individuals(=chromosomas=solutions)
numBits=6; % # bits per FP (about our codification)

population = RandomPopulation(numFP,numInd,numBits);


%% SECTION 4: GA loop

SecDistance=8; % security distance in NM
SimTime=5; % time increment in seconds
PercetageElitism=0.1;
numElitism=fix(PercetageElitism*numInd); % # individuals copied in the new population
numNoElitism=numInd-numElitism; % # individuals that have to enter in the roulette
Pm=0.02; % Probability of mutation
numMutated=fix(Pm*numInd); % # individuals that have to mutate

repetitions = 1; % counter of the number of generations of new populations
equalresults=0; % counter of the number of times in which the best solutions of consecuent populations have the same fitness value
solutions=[]; % vector of the fitness value of the best individual of each population
BestAffectedConflict=[]; % matrix of the number of affected FP and the number of conflicts of the best individual of each population

best=[];

continuesimulation=true;
while(continuesimulation==true)

    % FITNESS
    FitnessVector=zeros(numInd,1);
    for Chrom=1:1:numInd % evaluates each individual in population
        [ListFPm,AllVel,AllAng,AllDist] = ModifyListFP(ListFPi,numFP,population(Chrom,:)); % Modifies each flight plan according to each solution (individual) 
        numAffected = GetAffected(ListFPi, ListFPm,numFP); % computes the number of affected aircrafts
        numConflicts = GetConflicts(ListFPm,SecDistance,SimTime,numFP); % computes the number of conflicts between FPs
        FitnessVector(Chrom) = fitness(numAffected,numConflicts, AllVel,AllAng,AllDist,numFP,numInd); % computes the fitness of each individual of the population
    end
    FitnessVector_Sorted=sort(FitnessVector); % fitness values sorted (minimum first)
    FitnessVectorSorted_new = index_sort(FitnessVector,FitnessVector_Sorted); % fitness value sorted and index of this solution in population matrix
    
    % NEW POPULATION
    populationNEW = zeros(size(population,1),size(population,2));
    Elitism = FitnessVectorSorted_new(1:numElitism,:); % 10% bette r solutions
    NoElitism = FitnessVectorSorted_new(numElitism+1:end,:); % 90% worst solutions
    populationNEW(1:numElitism,:) = population(Elitism(:,2),:); % elitist solutions copied
    newPopulationIndex = numElitism + 1;
    while(newPopulationIndex<numInd)
        choice = RouletteWheel(NoElitism); % random choice index 1 
        solution_1 = population(NoElitism(choice,2),:); % random choice solution 1
        choice = RouletteWheel(NoElitism); % random choice index 2
        solution_2 = population(NoElitism(choice,2),:); % random choice solution 2
        [solution_jr_1,solution_jr_2] = crossover(solution_1,solution_2); % CROSSOVER 
        populationNEW(newPopulationIndex,:) = solution_jr_1; 
        newPopulationIndex = newPopulationIndex + 1;
        if(newPopulationIndex<numInd)
            populationNEW(newPopulationIndex,:) = solution_jr_2;
            newPopulationIndex = newPopulationIndex + 1;
        end
    end
    mutatedPopulation = mutation(populationNEW, numInd, numMutated); % MUTATION
    
    % BEST SOLUTION
    solutions(1,repetitions) = FitnessVector_Sorted(1,1); % store fitness value in a vector
    index_best=FitnessVectorSorted_new(1,2); % index 
    [ListFPm_best,~,~,~] = ModifyListFP(ListFPi,numFP,population(index_best,:)); % modified FP
    BestAffectedConflict(repetitions,1) = GetAffected(ListFPi, ListFPm_best,numFP); % store number of affected
    BestAffectedConflict(repetitions,2) = GetConflicts(ListFPm_best,SecDistance,SimTime,numFP); % store number of conflicts
    best(repetitions,:) = population(index_best,:);
    
    % FINISH THE LOOP: when at least 25 populations have the same better fitness value
    if(repetitions>1 && solutions(1,repetitions-1)==solutions(1,repetitions)) 
        equalresults=equalresults+1; % count repetitions
    else
        equalresults=0;
    end
    
    if(equalresults>=25) % stop simulation        
        continuesimulation=false;
    else % go on with the simulation
        repetitions=repetitions+1
        population=mutatedPopulation;
    end
    
end



%% SECTION 5: results

figure('NumberTitle', 'off', 'Name', 'Best solution per iteration');
x = 1:1:repetitions;
plot(x,solutions)
xlabel("Iteration")
ylabel("Fitness value")

figure('NumberTitle', 'off', 'Name', 'Number of conflicts & affected flights per iteration');
subplot(2,1,1)
plot(x,BestAffectedConflict(:,1))
xlabel("Iteration")
ylabel("Affected FP")
subplot(2,1,2)
plot(x,BestAffectedConflict(:,2))
xlabel("Iteration")
ylabel("Conflicts between FPs")

angles = plot_solution(ListFPi,ListFPm_best);

