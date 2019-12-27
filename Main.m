%% SECTION 1: clean MATLAB

clc
clear all
close all


%% SECTION 2: read airspace from files (sector + flight plans)

% fSector="sector"; % data file of sector     ---> NO EXISTE
% LeerSector(fSector); %      ---> TAMPOCO EXISTE

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
numElitism=PercetageElitism*numInd; % # individuals copied in the new population
numNoElitism=numInd-numElitism; % # individuals that have to enter in the roulette
Pm=0.2; % Probability of mutation
numMutated=Pm*numInd; % # individuals that have to mutate

%while(determinar cu�ndo parar):    

    % FITNESS
    FitnessVector=zeros(numInd,1);
    for Chrom=1:1:numInd % computes the fitness of each individual of the population
        [ListFPm,AllVel,AllAng,AllDist] = ModifyListFP(ListFPi,numFP,population(Chrom,:)); % Modifies each flight plan according to each solution (individual) 
        numAffected = GetAffected(ListFPi, ListFPm,numFP);
        numConflicts = GetConflicts(ListFPm,SecDistance,SimTime,numFP);
        FitnessVector(Chrom) = fitness(numAffected,numConflicts, AllVel,AllAng,AllDist,numInd,numFP);
    end
    FitnessVector_SORTED=sort(FitnessVector); 
    
    % NEW POPULATION
    populationNEW=[];
        % 10% elitism
    Elitism=FitnessVector_SORTED(1:numElitism,1);
    for i=1:1:numElitism
        populationNEW(i,:)=Search_fromFitnessValue(Elitism(i), FitnessVector, population);
    end
        % 90% matching by RW
    NoElitism=FitnessVector_SORTED(numElitism+1:numInd,1);
    % FALTA TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    % MUTATION
    

    population=populationNEW;

%end

%% SECTION 5: results
%angles = plot_solution(ListFPi,ListFPm)    