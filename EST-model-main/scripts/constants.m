% Script defining constants, specifically the "units" dictionary.

global unit;
unit = containers.Map;


% Time.

unit("s")    = 1.;
unit("min")  = 60*unit("s");
unit("h")    = 60*unit("min");
unit("day")  = 24*unit("h");
unit("year") = 365*unit("day");


% energy
unit("J")  = 1.;
unit("kJ") = 1000*unit("J");
unit("MJ") = 1000*unit("kJ");
unit("GJ") = 1000*unit("MJ");


% Power
unit("W")  = unit("J")/unit("s");
unit("kW") = 1000*unit("W");
unit("MW") = 1000*unit("kW");
unit("GW") = 1000*unit("MW");


% energy (Wh)
unit("Wh")  = unit("W")*unit("h");
unit("kWh") = unit("kW")*unit("h");
unit("MWh") = unit("MW")*unit("h");
unit("GWh") = unit("GW")*unit("h");


% Resistance

unit("ohm") = 1.;


% Temperature.

unit("K") = 1.;


% Mass.

unit("kg") = 1.;


% Length.

unit("m") = 1.;


% Potential.

unit("V") = 1.;


% Current.

unit("A") = 1.;
