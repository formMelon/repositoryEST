port = "COM3";
baudRate = 9600;
s = serial(port, 'BaudRate', baudRate);
fopen(s);

fileName = "airFlowData.txt";
fileID = fopen(fileName, "w");

try
    while true
        dataLine = fscanf(s, "%s");
        fprintf(fileID, "%s", dataLine);
    end
catch
    fclose(fileID);
    fclose(s);
    disp("Finished collecting airflow data...");
end

data = readmatrix(fileName);

time = 1:length(data);
plot(time, data);
xlabel("t. Time [s]")
ylabel("y. Airflow [L/min]")
title("Airflow as a function of time time")
saveas(gcf, "airFlowPlot.eps")