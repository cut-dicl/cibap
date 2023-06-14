close all
clear 
clc
%           TAKING DATA FROM EXCEL FILE
% AAAA = 'limassolMarch2019_2week.xlsx';  % calling the excell file for one week data
% DataTable = readtable(AAAA,'Range','A1:M29');    %% reading the table from excell file 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%       DATA GENERATING RANDOMLY
% nnn=120; %prompt = 'Please state total number of ships? '; nnn = input(prompt);
% days=15; %prompt = 'Please enter number of days/ planing period? '; days = input(prompt);
% hours=days*24; %days multiply by hours in a day
% quays=3; %add 1-5;  prompt = 'Please enter number of Quays? '; quays = input(prompt);
% [DataTable]=Instances_generator(nnn,hours, quays); % select this for random data

%           READING AND WRITING DATA COMMANDS
%writestruct(DataTable, "C:\Users\Sheraz\Dropbox\randomDataResults\data\120v15d5q.xml"); % write structure data
DataTable=readstruct("C:\Users\Sheraz\Dropbox\randomDataResults\data\15v1d4q.xml");
days=1;



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
populationSize=100; noOfGeneration=100;
if max(PBQ)>1
[PBQ ABQ]=PBP_PBQ_function(LoS, PBQ, data.AT, LoW); % random population generation
data.ABQ=ABQ;
else
    data.ABQ=PBQ;
end
data.days=days;

%%%%%%%%%%%%% ALGO 1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   MILP CODE HERE      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
algo=1;
tic
[BT_MILP, BP_MILP, BQ_MILP]=MILP_BAP2(data, LoW);
Time_MILP=toc;
[x1]=mainplot(BT_MILP, BP_MILP, data.pTime, data.LoS, algo, 96);
%writematrix(BT_MILP, "BT_MILP.txt"); writematrix(BP_MILP, "BP_MILP.txt");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %calculating PBP for paper writeup
 %aa=PBP(a)-sum(LoW(1:data.PBQ(a)-1))

data.PBQ;
LoW;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Storing results in tex files                            %
% writematrix(BT_MILP, "C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BT_MILP_15v1d4q.txt"); 
% writematrix(BP_MILP, "C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BP_MILP_15v1d4q.txt"); 
% writematrix(BQ_MILP, "C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BQ_MILP_15v1d4q.txt"); 


% writematrix(Time_MILP, "C:\Users\Sheraz\Dropbox\randomDataResults\MILP\Time_MILP_10v1d2q.txt"); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% function for combined plots
%[x2]=Plots_combine(BT_CSA, BP_CSA, BT_GA, BP_GA, Quay, LoW, BestCostSoFar_GA, fmin_CSA_cost, Time_CSA, Time_GA, BT_MILP_new, BP_MILP_new, Time_MILP);

% Function for seperate plots for each quay
%[x1]=Plots(BT_CSA, BP_CSA, BT_GA, BP_GA, Quay, LoW, BestCostSoFar_GA, fmin_CSA_cost, Time_CSA, Time_GA, BT_MILP_new, BP_MILP_new, Time_MILP);

