% Pre-processing script for the EST Simulink model. This script is invoked
% before the Simulink model starts running. (initFcn callback function.)

%% Load the supply and demand data.

timeUnit   = 's';

supplyFile = "Team62_supply.csv";
supplyUnit = "kW";

% Load the supply data...
Supply = loadSupplyData(supplyFile, timeUnit, supplyUnit);

demandFile = "Team62_demand.csv";
demandUnit = "kW";

% Load the demand data...
Demand = loadDemandData(demandFile, timeUnit, demandUnit);

%% Simulation settings.

deltat = 5*unit("min");
stopt  = min([Supply.Timeinfo.End, Demand.Timeinfo.End]);

%% System parameters.

% Transport from supply.
stringVoltage = 408*unit("V"); % Considering a constant working voltage of 
% 24 V and strings of 17 solar panels. Per string that is a voltage of 408 
% V.
resistance = 0.00002373556*unit("ohm"); % Resistance in the wires from the
% solar panels to the inverter. Assuming a wire length of 5 m, a diameter
% of 8 mm, and copper as a conducter.
efficiencyInverter = 0.97; % Efficiency for solar inverter, ranges from
% 0.95 to 0.97.

% Injection system.
aNetInjection = 0.05; % Dissipation coefficient during injection.

% Storage system.
EStorageMax     = 350000*unit("kWh"); % Maximum energy for energy storage.
EStorageMin     = 0.0*unit("kWh"); % Minimum energy.
EStorageInitial = 0.0*unit("kWh"); % Initial energy.
bStorage        = 1e-8/unit("s");  % Energy storage dissipation 
% coefficient.
sb = 5.670374419*10^-8*(...
    unit("W")/unit("m")/unit("m")/unit("K")/unit("K")/unit("K")/unit("K")); 
% Constant of Stefan.
mass = 25837320*unit("kg"); % Mass of the thermal storage assuming the 
% use of water.
k = 0.04*unit("W")/unit("m")/unit("K"); % The thermal conductivity for the 
% insulation, syrafoam in this case.
areaOfTank = 6100*unit("m")*unit("m"); % Area of the thermal storage tank.
environmentalTemperature = 293*unit("K"); % Assumed to be constant but 
% could fluctuate between 5 and 23 degrees celcius in reality.
x = 1*unit("m"); % Thickness of insulation.
e = 0.07; % Emmissivity of the steel of the thermal storage tank, could 
% vary largely depending on the type of steel.

% Extraction system.
aExtraction = 0.11; % Dissipation coefficient including generator losses.

% Transport to demand.
aDemandTransport = 0.02; % Dissipation coefficient during high voltage 
% transport from the Flevopolder to distribution in Amsterdam.
efficiencyTransformer = 0.99; % Efficiency for step-ups and step-downs,
% ranges from 0.97 to 0.99.