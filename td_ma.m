%
clc
clear all
%% indicates no of sensors and slots
sensor= 5;
slots= 1:5;

%tracking count of sent and received data of each sensor, the index
%represents the sensor number.
DataSentCount = zeros(1, sensor);
DataRecCount = zeros(1, sensor);

%no of times sensors try to communicate
n = 100;
%noise coefficient
noiseCoeff = 1;

for time = 1:n
    % Each time slot is represented by a 1x5 matrix, each element of the matrix showing
    % the value sent by the respective sensor
    % In TDMA a particular time slot is reserved for a sensor
    % k is the index value to represent the sensor turn as a function of
    % time(time slot)
    k = rem(time,sensor);
    if rem(time,sensor) == 0
        k =5;
    end
    %indicates if the sensor has sent or if the sent data is received in a
    %particular time slot
    SigSentMat = zeros(1,sensor);
    SigRecMat = zeros(1, sensor);
    data = rand(1);
    Data = data >= 0.5;
    SigSentMat(k)=Data;
    % counting number of times each sensor has sent data in its given time
    % slot
    DataSentCount=DataSentCount+SigSentMat;
    if SigSentMat(k) == 1
        %SigSent = 1;
        SigRec=SigSentMat+noiseCoeff*randn(1,5);
        if SigRec(k) >= 0.5
            SigRecMat(k)= 1;
        end
    end
    DataRecCount = DataRecCount + SigRecMat;
end
subplot(2,1,1)
bar(DataSentCount)
subplot(2,1,2)
bar(DataRecCount)
