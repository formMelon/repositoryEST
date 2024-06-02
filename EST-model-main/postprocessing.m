% Post-processing script for the EST Simulink model. This script is invoked
% after the Simulink model is finished running (stopFcn callback function).

close all;

disp('StopFcn executed');

%% Supply
figure;
plot(tout/unit("day"), PSupply/unit("W"));
xlim([0 tout(end)/unit("day")]);
grid on;
title('Supply');
xlabel('Time [day]');
ylabel('Power [W]');

%% Demand
figure;
plot(tout/unit("day"), PDemand/unit("W"));
xlim([0 tout(end)/unit("day")]);
grid on;
title('Demand');
xlabel('Time [day]');
ylabel('Power [W]');

figure;
plot(tout/unit("day"), PDemand/unit("W"));
xlim([0 tout(end)/unit("day")]);
grid on;
title('Demand');
xlabel('Time [day]');
ylabel('Power [W]');

%% Supply and demand
subplot(2,2,1);
plot(tout/unit("day"), PSupply/unit("W"));
hold on;
plot(tout/unit("day"), PDemand/unit("W"));
hold off;
xlim([0 tout(end)/unit("day")]);
grid on;
title('Supply and demand');
xlabel('Time [day]');
ylabel('Power [W]');
legend("Supply", "Demand");

%% Stored energy
subplot(2,2,2);
plot(tout/unit("day"), EStorage/unit("J"));
xlim([0 tout(end)/unit("day")]);
grid on;
title('Storage');
xlabel('Time [day]');
ylabel('Energy [J]');

%% Energy losses
subplot(2,2,3);
plot(tout/unit("day"), D/unit("W"));
xlim([0 tout(end)/unit("day")]);
grid on;
title('Losses');
xlabel('Time [day]');
ylabel('Dissipation rate [W]');

%% Load balancing
subplot(2,2,4);
plot(tout/unit("day"), PSell/unit("W"));
hold on;
plot(tout/unit("day"), PBuy/unit("W"));
xlim([0 tout(end)/unit("day")]);
grid on;
title('Load balancing');
xlabel('Time [day]');
ylabel('Power [W]');
legend("Sell", "Buy");

%% Pie charts

% integrate the power signals in time
EfromSupplyTransport = trapz(tout, PfromSupplyTransport);
EtoDemandTransport   = trapz(tout, PtoDemandTransport);
ESell                = trapz(tout, PSell);
EBuy                 = trapz(tout, PBuy);
EtoInjection         = trapz(tout, PtoInjection);
EfromExtraction      = trapz(tout, PfromExtraction);
EStorageDissipation  = trapz(tout, DStorage);
EDirect              = EfromSupplyTransport - ESell - EtoInjection;
ESurplus             = EtoInjection - EfromExtraction -EStorageDissipation;

figure;
tiles = tiledlayout(1,2);

ax = nexttile;
pie(ax, [EDirect, EtoInjection, ESell]/EfromSupplyTransport);
lgd = legend(["Direct to demand", "To storage", "Sold"]);
lgd.Layout.Tile = "south";
title(... 
    sprintf("Received energy %3.2e [J]", EfromSupplyTransport/unit('J')));

ax = nexttile;
pie(ax, [EDirect, EfromExtraction, EBuy]/EtoDemandTransport);
lgd = legend(["Direct from supply", "From storage", "Bought"]);
lgd.Layout.Tile = "south";
title(sprintf("Delivered energy %3.2e [J]", EtoDemandTransport/unit('J')));

%% Other pie chart

% Integrate the dissipation power signals

EDSupplyTransport  = trapz(tout, DSupplyTransporta);
EDDemandTransport  = trapz(tout, DDemandTransporta);
EDInjection        = trapz(tout, DInjectiona);
EDStorage          = trapz(tout, DStorageinda);
EDTStorage         = trapz(tout, TStorageLossa);
EDExtraction       = trapz(tout, DExtractiona);
DTotal             = trapz(tout, D);

figure;
pie([EDSupplyTransport, EDDemandTransport, EDInjection, EDStorage, ...
    EDExtraction]/DTotal);
lgd = legend(["From supply", "To demand", "Injection", "Storage", ...
    "Extraction"]);
title(sprintf("Dissipated energy %3.2e [J]", DTotal/unit('J')));

%% Last pie chart

figure;
pie([EDStorage, EDTStorage]/DTotal);
lgd = legend(["Energy Storage", "Thermal Storage"]);
