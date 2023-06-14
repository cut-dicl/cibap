function [AT_30min, dep_30min, pTime]=dataModify(DataTable) %


%%%%%%%%%%%%%%%%%%%% ARRIVAL TIMES CALCULATION  %%%%%%%%%%%%%%%%

AT=DataTable.ETA_Berth'; % arrival time estimated with date 
%AT1=timeofday(AT); % only times HH:MM:SS
AT_30min=hour(AT)*2; % making hours to 2 units of 30 30 minutes
ccc=minute(AT);
for i=1:length(AT)
if ccc(i)>30 || ccc(i)==30
AT_30min(i)=AT_30min(i)+1;
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%% calculating 30min units for a whole month

dateOfARRIVAl=day(AT); % date march 2018
for i=1:length(AT)
if dateOfARRIVAl(i)>1
    xx=(dateOfARRIVAl(i)-1)*48;
AT_30min(i)=AT_30min(i)+xx;
end
end





%%%%%%%%%%%%%%% DEPARTURE TIME CALCULATION   %%%%%%%%%%%%%%%%%%%%

departure=DataTable.ATD_Berth'; % requested/ estimated departure times of ships
dep_30min=hour(departure)*2;
ccc=minute(departure);
for i=1:length(departure)
if ccc(i)>0 && ccc(i) <31
dep_30min(i)=dep_30min(i)+1;
elseif ccc(i)>30
dep_30min(i)=dep_30min(i)+2;    
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%% calculating 30min units for a whole month
dateOfDEPARTURE=day(departure); % date march 2018
for i=1:length(departure)
if dateOfDEPARTURE(i)>1
    xx=(dateOfDEPARTURE(i)-1)*48;
dep_30min(i)=dep_30min(i)+xx;
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Processing TIME %%%%%%%%%%%%
pTime=DataTable.timeWorking'; % processing time of all vessels to unload or load
pTime=floor(pTime/30); %round function nearest integer



