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
SecDistance=8; %NM
SimTime=5; %seconds
PercetageElitism=0.1;
%while(determinar cuándo parar):    
    FitnessVector=zeros(numInd,1);
    
    for Chrom=1:1:numInd
        [ListFPm,AllVel,AllAngles,AllDist] = ModifyListFP(ListFPi,numInd,population(Chrom,:));
        numAffected = GetAffected(ListFPi, ListFPm,numFP);
        numConflicts = GetConflicts(ListFPm,SecDistance,SimTime,numFP);
        FitnessVector(Chrom) = fitness(numAffected,numConflicts, AllVel,AllAng,AllDist,numInd,numFP);
    end
    FitnessVector=sort(FitnessVector);
    numElitism=PercetageElitism*length(FitnessVector);
    Elitism=FitnessVector(1:numElitism,1);
    
