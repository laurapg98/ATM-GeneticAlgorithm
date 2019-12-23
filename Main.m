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

%while(determinar cu�ndo parar):    
    FitnessVector=zeros(numInd,1);
    
    % FITNESS
    for Chrom=1:1:numInd % computes the fitness of each individual of the population
        [ListFPm,AllVel,AllAngles,AllDist] = ModifyListFP(ListFPi,numInd,population(Chrom,:)); 
        numAffected = GetAffected(ListFPi, ListFPm,numFP);
        numConflicts = GetConflicts(ListFPm,SecDistance,SimTime,numFP);
        FitnessVector(Chrom) = fitness(numAffected,numConflicts, AllVel,AllAng,AllDist,numInd,numFP);
    end
    
    % NEW POPULATION
    FitnessVector=sort(FitnessVector); 
    Elitism=FitnessVector(1:numElitism,1);
    NoElitism=FitnessVector(numElitism+1:numInd,1);
    
    % MUTATION
    