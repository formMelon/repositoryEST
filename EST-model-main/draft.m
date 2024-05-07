%% Basically here is a draft only for determining where energy goes at a certaint time

%% For i of every time t in the year, in length of t
    %% net = P(i)Supply - P(i)Demand
    %% if net > 0
        %% if EStorage(i) > EStorageMax
            %% Estorage(i) = Estorage(i) + integral of P(i)Supply from i to i+1
        %% else SELL to grid
    %% elif net = 0 or like around zero
        %% Do nothing
    %% else 
        %% BUY and go to demand or if EStorage >0 then discharge that

%% Now to go to energy losses, yikes... They should be divided in different sections I guess

%% SUPPLY for i in every t within P(t)
    %% PSupplyLoss = 

%% Injection
    %% PInjectorUse = x

%% 