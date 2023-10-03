close all;
clear all;
clc;

%% load functions
for reg_loadAllFolder = 1:1
    folder = fileparts(mfilename('fullpath')); 
    addpath(genpath(folder));
end


%% Generate Data
Beta = [10; 28; -0.01]; 
n = 6;
x0=[0;0;0;-8; 8; 27]; 
tspan=[.01:.01:50]';
options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));

FO_mag = 5;
FO_freq = 1.3;

oscillationFreq = FO_freq;


[t,x]=ode45(@(t,x) modiLorenz_ForceSine(t,x,Beta,FO_mag,FO_freq),tspan,x0,options);

figure()
subplot(2,1,1);
plot(tspan,x(:,1));
hold on;
plot(tspan,x(:,2));
hold on;
plot(tspan,x(:,3));
legend("x_{delta1}","x_{delta2}","x_{delta3}");
xlabel("time (seconds)");

subplot(2,1,2);
plot(tspan,x(:,4));
hold on;
plot(tspan,x(:,5));
hold on;
plot(tspan,x(:,6));
legend("x_{freq1}","x_{freq2}","x_{freq3}");
xlabel("time (seconds)");

