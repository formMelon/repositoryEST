port = "COM3";
baudRate = 9600;
serialPort = serialport(port, buadRate);
fopen(serialPort);

fileName = "pressureData.txt";
fileID = fopen(fileName, "w");

try
    while true
        dataLine = fscanf(serialPort, "%serialPort");
        fprintf(fileID, "%serialPort/n", dataLine);
    end
catch
    fclose(fileID);
    fclose(serialPort);
    disp("Finished collecting pressure data...");
end

data = readmatrix(fileName);

time = 1:length(data);
plot(time, data);
xlabel("t. Time []")
ylabel("p. Pressure []")
title("Pressure as a function of time")
saveas(gcf, "pressurePlot.eps")