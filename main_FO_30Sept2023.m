close all;
clear all;
clc;

% load all functions
for reg_loadAllFolder = 1:1
    folder = fileparts(mfilename('fullpath')); 
    addpath(genpath(folder));
end


% load data
%% FO in modified Lorenz system 
%load('modiLorenz_FoXFreq1.mat'); load('modiLorenz_label.mat'); lambda = 1e-8; fs = 100; generatorLabel= generatorLabel;


%% FO from Test Cases Library of Power System Sustained Oscillations
load('F7.mat'); load('simCase_generatorLabel.mat'); lambda = 1e-8; fs = 30;  generatorLabel= ISO_real_generatorLabel;


%% FO from Real Cases Library  
%load('ISOcase3.mat'); load('ISO_real_generatorLabel.mat');lambda = 1e-8; fs = 30; fileName = 'ISOcase3.mat';generatorLabel= ISO_real_generatorLabel;



%% find FO from load data 
%{
    f: [rotorAngle Frequency timestamp]
        Assume 'n' generators, size of f is (n+n+1) \times timeWindow/fs

    oscillationFreq: interested oscillation frequency 
        size of oscillationFreq is 1 \times number of interested
        oscillation frequencies

    lambda: sparsity threshold

    fs: data sampling frequency (eg: f(2, end) - f(1, end))

%} 
[Xi_ab] = fun_FO_Xi_ab_29Sept2023(f, oscillationFreq, lambda, fs);

%% plot
fun_FO_Xi_ab_plotting_29Sept2023(f, oscillationFreq, generatorLabel, Xi_ab);



