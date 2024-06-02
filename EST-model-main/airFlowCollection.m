port = "COM3";
baudRate = 9600;
serialPort = serialport(port, baudRate);
fopen(serialPort);

fileName = "airFlowData.txt";
fileID = fopen(fileName, "w");

try
    while true
        dataLine = fscanf(serialPort, "%serialPort");
        fprintf(fileID, "%serialPort\n", dataLine);
    end
catch
    fclose(fileID);
    fclose(serialPort);
    disp("Finished collecting airflow data...");
end

data = readmatrix(fileName);

time = 1:length(data);
plot(time, data);
xlabel("t. Time [s]")
ylabel("y. Airflow [L/min]")
title("Airflow as a function of time time")
saveas(gcf, "airFlowPlot.eps")