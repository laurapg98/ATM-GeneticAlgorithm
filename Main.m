%% SECTION 1: clean MATLAB
clc
clear all
close all

%% SECTION 2: read airspace from files (sector + flight plans)
% fSector="sector"; % data file of sector     ---> NO EXISTE
% LeerSector(fSector); %      ---> TAMPOCO EXISTE
fFP="FlightPlans.txt"; % data file of flight plans
[listFP,numFP]=ReadFP(fFP); 

%% SECTION 3: create initial population
numInd=100; % # individuals(=chromosomas=solutions)
numBits=5; % # bits per FP (about our codification)
population = RandomPopulation(Nvuelos,Poblacion,Nbits);

%% SECTION 4: GA loop
%while(determinar cuándo parar):
