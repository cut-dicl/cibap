close all
clear 
clc

DataTable=readstruct("C:\Users\Sheraz\Dropbox\randomDataResults\data\10v1d1q.xml");

%                   VARIOUS COSTS
C_W_hour=10/2; % 10 eur per hour... divided by 2 because of 30 min slot
C_H_hour=20/2; % 20 eur per hour... divided by 2 because of 30 min slot
C_NOP_meter=2; % non optimal berthing position cost per meter
C_NOQ=50; % penalty cost if the ship is not moored at preferred quay
C_LD=40/2; % % 40 eur per hour... divided by 2 because of 30 min slot

LoS=DataTable.vessellength'; % length of ship
LoS=LoS+10; % addind 10meters extra because of safety distance
LoW=DataTable.LoW;
PBP=DataTable.LowestCostBerthingPos_;
data.PBP=PBP;
PBQ=DataTable.PBQ; data.PBQ=PBQ;
AT_30min=DataTable.ArrivalTimeOfVessel*2; %converting into 30min time slot
dep_30min=DataTable.RequestedDep_Time*2;
pTime=DataTable.ProcessingTimeOfVessel*2;
pTime=pTime+1;% adding 1 slot (30 minutes) extra because of safety time
data.AT=AT_30min; data.dep=dep_30min+2; data.pTime=pTime; data.LoS=LoS; %data.PBQ_name=PBQ_name;

if max(PBQ)>1
[PBQ ABQ]=PBP_PBQ_function(LoS, PBQ, data.AT, LoW); % random population generation
data.ABQ=ABQ;
else
    data.ABQ=PBQ;
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%                        CSA RESULTS                         %%%%%%%
BT_CSA = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\CSA\BT_CSA_10v1d1q.txt');
BP_CSA = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\CSA\BP_CSA_10v1d1q.txt');
BQ_CSA = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\CSA\BQ_CSA_10v1d1q.txt');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%                        GA RESULTS                         %%%%%%%
BT_GA = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\GA\BT_GA_10v1d1q.txt');
BP_GA = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\GA\BP_GA_10v1d1q.txt');
BQ_GA = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\GA\BQ_GA_10v1d1q.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%                        PSO RESULTS                         %%%%%%%
BT_PSO= importdata('C:\Users\Sheraz\Dropbox\randomDataResults\PSO\BT_PSO_10v1d1q.txt');
BP_PSO = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\PSO\BP_PSO_10v1d1q.txt');
BQ_PSO = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\PSO\BQ_PSO_10v1d1q.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%                        MILP RESULTS                         %%%%%%%
BT_MILP= importdata('C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BT_MILP_10v1d1q.txt');
BP_MILP = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BP_MILP_10v1d1q.txt');
BQ_MILP = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BQ_MILP_10v1d1q.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%      WAITING TIMEs by CSA, GA, PSO, and MILP   %%%%%%%%%%%%%%%
for a=1:length(BT_CSA)
    waitingTime_CSA(a)=BT_CSA(a)-data.AT(a);
        if waitingTime_CSA(a)<0
            waitingTime_CSA(a)=0;
        end
%GA
    waitingTime_GA(a)=BT_GA(a)-data.AT(a);
        if waitingTime_GA(a)<0
            waitingTime_GA(a)=0;
        end
%PSO
    waitingTime_PSO(a)=BT_PSO(a)-data.AT(a);
        if waitingTime_PSO(a)<0
            waitingTime_PSO(a)=0;
        end
%MILP
    waitingTime_MILP(a)=BT_MILP(a)-data.AT(a);
        if waitingTime_MILP(a)<0
            waitingTime_MILP(a)=0;
        end
end%%%%
%               WAITING COSTS by CSA, GA, PSO, and MILP
waiting_cost_CSA=waitingTime_CSA*C_W_hour; 
waiting_cost_GA=waitingTime_GA*C_W_hour;
waiting_cost_PSO=waitingTime_PSO*C_W_hour;
waiting_cost_MILP=waitingTime_MILP*C_W_hour;
total_waiting_cost_CSA=sum(waiting_cost_CSA); % total waiting cost CSA
total_waiting_cost_GA=sum(waiting_cost_GA); % total waiting cost GA
total_waiting_cost_PSO=sum(waiting_cost_PSO); % total waiting cost PSO
total_waiting_cost_MILP=sum(waiting_cost_MILP); % total waiting cost MILP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Handling cost
for a=1:length(data.AT)
    handling_cost_CSA(a)=(pTime(a)-1)*C_H_hour; % 1 is deducted due to extra for ST
    handling_cost_GA(a)=(pTime(a)-1)*C_H_hour;
    handling_cost_PSO(a)=(pTime(a)-1)*C_H_hour;
    handling_cost_MILP(a)=(pTime(a)-1)*C_H_hour;
%CSA
    if abs(BP_CSA(a)-PBP(a)) >0
        handling_cost_CSA(a)=handling_cost_CSA(a)+abs(BP_CSA(a)-PBP(a))*C_NOP_meter; 
        NOB_cost_CSA(a)=abs(BP_CSA(a)-PBP(a))*C_NOP_meter;
    end
    if data.PBQ(a)~=BQ_CSA(a)
        handling_cost_CSA(a)=((pTime(a)-1)*10)+C_NOQ; % 50 is a penalty for ABQ
        NOB_cost_CSA(a)=C_NOQ;
    end

%GA
    if abs(BP_GA(a)-PBP(a)) >0
        handling_cost_GA(a)=handling_cost_GA(a)+abs(BP_GA(a)-PBP(a))*C_NOP_meter; 
        NOB_cost_GA(a)=abs(BP_GA(a)-PBP(a))*C_NOP_meter; 
    end
    if data.PBQ(a)~=BQ_GA(a)
        handling_cost_GA(a)=((pTime(a)-1)*10)+C_NOQ; % 50 is a penalty for ABQ
        NOB_cost_GA(a)=C_NOQ;
    end

%PSO
    if abs(BP_PSO(a)-PBP(a)) >0
        handling_cost_PSO(a)=handling_cost_PSO(a)+abs(BP_PSO(a)-PBP(a))*C_NOP_meter; 
        NOB_cost_PSO(a)=abs(BP_PSO(a)-PBP(a))*C_NOP_meter;
    end
    if data.PBQ(a)~=BQ_PSO(a)
        handling_cost_PSO(a)=((pTime(a)-1)*10)+C_NOQ; % 50 is a penalty for ABQ
        NOB_cost_PSO(a)=C_NOQ;
    end

%MILP
    if abs(BP_MILP(a)-PBP(a)) >0
        handling_cost_MILP(a)=handling_cost_MILP(a)+abs(BP_MILP(a)-PBP(a))*C_NOP_meter; 
        NOB_cost_MILP(a)=abs(BP_MILP(a)-PBP(a))*C_NOP_meter;
    end
    if data.PBQ(a)~=BQ_MILP(a)
        handling_cost_MILP(a)=((pTime(a)-1)*10)+C_NOQ; % 50 is a penalty for ABQ
        NOB_cost_MILP(a)=C_NOQ;
    end
end
Total_handling_cost_CSA=sum(handling_cost_CSA); % total handling cost ny CSA
Total_handling_cost_GA=sum(handling_cost_GA); % total handling cost ny GA
Total_handling_cost_PSO=sum(handling_cost_PSO); % total handling cost ny PSO
Total_handling_cost_MILP=sum(handling_cost_MILP); % total handling cost ny MILP


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       LATE DEPARTURE COST
for a=1:length(data.AT)
%CSA
    if BT_CSA(a)+data.pTime(a)>data.dep(a)
        late_departure_CSA(a)=BT_CSA(a)+data.pTime(a)-data.dep(a);  % late deparature time
    else
        late_departure_CSA(a)=0;
    end
    late_departure_cost_CSA(a)=late_departure_CSA(a)*C_LD; % late deparature cost

%GA
    if BT_GA(a)+data.pTime(a)>data.dep(a)
        late_departure_GA(a)=BT_GA(a)+data.pTime(a)-data.dep(a);
    else
        late_departure_GA(a)=0;
    end
    late_departure_cost_GA(a)=late_departure_GA(a)*C_LD; % late deparature cost

%PSO
    if BT_PSO(a)+data.pTime(a)>data.dep(a)
        late_departure_PSO(a)=BT_PSO(a)+data.pTime(a)-data.dep(a);
    else
        late_departure_PSO(a)=0;
    end
    late_departure_cost_PSO(a)=late_departure_PSO(a)*C_LD; % late deparature cost

%MILP
    if BT_MILP(a)+data.pTime(a)>data.dep(a)
        late_departure_MILP(a)=BT_MILP(a)+data.pTime(a)-data.dep(a);
    else
        late_departure_MILP(a)=0;
    end
    late_departure_cost_MILP(a)=late_departure_MILP(a)*C_LD; % late deparature cost
end

Total_cost_CSA=sum(waiting_cost_CSA)+sum(handling_cost_CSA)+sum(late_departure_cost_CSA);
Total_cost_GA=sum(waiting_cost_GA)+sum(handling_cost_GA)+sum(late_departure_cost_GA);
Total_cost_PSO=sum(waiting_cost_PSO)+sum(handling_cost_PSO)+sum(late_departure_cost_PSO);
Total_cost_MILP=sum(waiting_cost_MILP)+sum(handling_cost_MILP)+sum(late_departure_cost_MILP);
NOB_cost_MILP; NOB_cost_PSO; NOB_cost_GA; NOB_cost_CSA;
%%%%%%%%%%%%%       PLOTS     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %[x1]=mainplot(BT_PSO, BP_PSO, data.pTime, data.LoS, algo);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% function for combined plots
[x2]=Plots_combine(BT_CSA, BP_CSA, BQ_CSA, BT_GA, BP_GA, BQ_GA, BT_PSO, BP_PSO, BQ_PSO, BT_MILP, BP_MILP, BQ_MILP, LoW, Time_CSA, Time_GA, Time_PSO, Time_MILP, data, Total_cost_CSA, Total_cost_GA, Total_cost_PSO, Total_cost_MILP, waitingTime_CSA, waitingTime_GA, waitingTime_PSO, waitingTime_MILP, NOB_cost_MILP, NOB_cost_PSO, NOB_cost_GA, NOB_cost_CSA);

% Function for seperate plots for each quay
%[x1]=Plots(BT_CSA, BP_CSA, BT_GA, BP_GA, Quay, LoW, BestCostSoFar_GA, fmin_CSA_cost, Time_CSA, Time_GA, BT_MILP_new, BP_MILP_new, Time_MILP);
