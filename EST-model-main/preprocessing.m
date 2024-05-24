% Pre-processing script for the EST Simulink model. This script is invoked
% before the Simulink model starts running (initFcn callback function).

%% Load the supply and demand data

timeUnit   = 's';

supplyFile = "Team62_supply.csv";
supplyUnit = "kW";

% load the supply data
Supply = loadSupplyData(supplyFile, timeUnit, supplyUnit);

demandFile = "Team62_demand.csv";
demandUnit = "kW";

% load the demand data
Demand = loadDemandData(demandFile, timeUnit, demandUnit);

%% Simulation settings

deltat = 5*unit("min");
stopt  = min([Supply.Timeinfo.End, Demand.Timeinfo.End]);

%% System parameters

% transport from supply
resistance = 0.00002373556*unit("ohm"); % Resistance in the wires from 
% solar panel panels to the inverter.
aInverter = 0.03; % Coefficient for loss from solar inverter, ranges from 
% 0.05 to 0.03
efficiencyTransformer = 0.99; % For step-ups and step-downs, ranges from 
% 0.97 to 0.99


% injection system
aInjection = 0.05; % Dissipation coefficient during injection

% Storage system

EStorageMax     = 135000.*unit("kWh"); % Maximum energy for energy storage
EStorageMin     = 0.0*unit("kWh"); % Minimum energy
EStorageInitial = 0.0*unit("kWh"); % Initial energy
TStorageMax     = 45000.*unit("kWh"); % Maximum energy
TStorageMin     = 0.0*unit("kWh"); % Minimum energy
TStorageInitial = 0.0*unit("kWh"); % Initial energy for thermal storage
bStorage        = 1e-6/unit("s");  % Energy storage dissipation coefficient
sb = 5.670374419*10^-8*(...
    unit("W")/unit("m")/unit("m")/unit("K")/unit("K")/unit("K")/unit("K")); 
% Constant of Stefan
mass = 40500000000*unit("kg"); % Mass of the thermal storage assuming the 
% use of water
k = 36*unit("W")/unit("m")/unit("K"); % The thermal conductivity for the 
% steel tanks
areaOfTank = 4100; % Area of the tanks, likely larger than suggested here
environmentalTemperature = 293*unit("K"); % Assumed to be constant but 
% could fluctuate between 5 and 23 degrees celcius.
x = 0.1*unit("m"); % Thickness of tank
e = 0.07; % Emmissivity of the steel of the tanks, could vary largely 
% depending on the type of steel

% extraction system
aExtraction = 0.15; % Dissipation coefficient including generator losses.

% transport to demand
aDemandTransport = 0.02; % Dissipation coefficient during high voltage 
% transport from the Flevopolder to distribution in Amsterdam