%% SECTION 1: limpiar lo que tengamos anterior
clc
clear all
close all

%% SECTION 2: leemos sector y vuelos
fSector="sector"; % fichero datos sector
fFP="FlightPlans.txt"; % fichero datos vuelos
[listaFP,Nvuelos]=LeerFP(fFP); % da una matriz de FP a partir del fichero datos vuelos

%% SECTION 3: Generamos población inicial
Poblacion=100;
Matriz_poblacion = PoblacionInicial(Nvuelos,Poblacion);
FP1=listaFP(1,:);
FP2=listaFP(2,:);
Conflicto=Conflicto_2FP(5,1,FP1,FP2)