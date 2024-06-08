port = "COM3";
baudRate = 9600;
s = serial(port, 'baudrate', baudRate);
fopen(s);

fileName = "pressureData.txt";
fileID = fopen(fileName, "w");

try
    while true
        dataLine = fscanf(s, "%s");
        fprintf(fileID, "%s", dataLine);
    end
catch
    fclose(fileID);
    fclose(s);
    disp("Finished collecting pressure data...");
end

data = readmatrix(fileName);

time = 1:length(data);
plot(time, data);
xlabel("t. Time [s]")
ylabel("p. Pressure [kPa]")
title("Pressure as a function of time")