% Control of Preesure, Flow rate and cylinder volumep
% For Teladyne ISCO pump 65DM
% Thomas COCHARD - Harvard University - Feburary 2019

clear
close all
clc

global volume t s pump_id pressure real_time time FR;
volume = []; t = 0;
pressure = []; time = []; real_time = []; FR=[];

% pump initialization 
fclose(instrfind);
port = 'COM4';   % Serial port where the pump is plugged
pump_id = 6;     % Pump ID number

s = serial(port); % create serial port object

set(s,'BaudRate',115200,'Terminator','CR','Timeout',10); % set serial port propertie
fopen(s);

[~]=ISCO_comm(s,pump_id,'REMOTE'); 
out=ISCO_comm(s,pump_id,'CONST PRESS'); 
out=ISCO_comm(s,pump_id,'PRESS=10');
out=ISCO_comm(s,pump_id,'RUN');
real_time = tic; read_volume();

pause (10)

for i = 20:10:50
    out=ISCO_comm(s,pump_id,['PRESS=' num2str(i)]); read_volume();
    pause (10)
end
out=ISCO_comm(s,pump_id,'STOP'); 
out=ISCO_comm(s,pump_id,'CONST FLOW'); 
out=ISCO_comm(s,pump_id,'FLOW=0.3');
out=ISCO_comm(s,pump_id,'RUN'); 

while true
    read_volume()
    pause(0.2)
end


figure (1)
plot(time, pressure,'o')
figure (2)
plot(time, volume,'o')
figure ()
subplot(3,1,1)
plot(time, pressure,'o')
figure (3,1,2)
plot(time, FR,'o')


 files = dir('Data*.mat');
 count = numel(files);
 save(['DataPump_' num2str(count+1,3) '.mat'],'time','volume','pressure','FR')



