%% SECTION 1: limpiar lo que tengamos anterior
clc
clear all
close all

%% SECTION 2: leemos sector y vuelos
fSector="sector"; % fichero datos sector
fFP="vuelos"; % fichero datos vuelos
listaFP=LeerFP(fFP); % da una matriz de FP a partir del fichero datos vuelos
