close all
clear 
clc
costs = 'costs.xlsx';  % calling the cost file
costs = readtable(costs,'Range','A1:K2'); 
%           TAKING DATA FROM EXCEL FILE
% AAAA = 'limassolMarch2019_2week.xlsx';  % calling the excell file for one week data
% DataTable = readtable(AAAA,'Range','A1:M29');    %% reading the table from excell file 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%       DATA GENERATING RANDOMLY
 nnn=20; %prompt = 'Please state total number of ships? '; nnn = input(prompt);
 days=2; %prompt = 'Please enter number of days/ planing period? '; days = input(prompt);
 hours=days*24; %days multiply by hours in a day
 quays=3; %add 1-5;  prompt = 'Please enter number of Quays? '; quays = input(prompt);
 [DataTable]=Instances_generator(nnn,hours, quays); % select this for random data

%           READING AND WRITING DATA COMMANDS
%writestruct(DataTable, "C:\Users\Sheraz\Dropbox\randomDataResults\data\120v15d5q.xml"); % write structure data
%DataTable=readstruct("C:\Users\Sheraz\Dropbox\randomDataResults\data\20v2d1q.xml");




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


%%%%%%%%%%%%% ALGO 1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   CODE of PSO ALGORITHM HERE  %%%%%%%%%%%%%%%%%
 algo=1;
 tic
 [PSO_BestPosition PSO_BestCost]=PSO(data, LoW, costs);
 BT_PSO=PSO_BestPosition(1:length(data.AT));
 BP_PSO=PSO_BestPosition(length(data.AT)+1:end-length(data.AT));
 BQ_PSO=PSO_BestPosition(end-length(data.AT)+1:end);
 Time_PSO=toc;
 [x1]=mainplot(BT_PSO, BP_PSO, data.pTime, data.LoS, algo, 96);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Storing results in tex files                            %

% writematrix(BT_PSO, "C:\Users\Sheraz\Dropbox\randomDataResults\PSO\BT_PSO_30v2d5q.txt"); 
% writematrix(BP_PSO, "C:\Users\Sheraz\Dropbox\randomDataResults\PSO\BP_PSO_30v2d5q.txt"); 
% writematrix(BQ_PSO, "C:\Users\Sheraz\Dropbox\randomDataResults\PSO\BQ_PSO_30v2d5q.txt"); 
% writematrix(Time_PSO, "C:\Users\Sheraz\Dropbox\randomDataResults\PSO\Time_PSO_30v2d5q.txt"); 
% writematrix(PSO_BestCost, "C:\Users\Sheraz\Dropbox\randomDataResults\PSO\Cost_PSO_30v2d5q.txt"); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% function for combined plots
[x2]=Plots_combine(BT_CSA, BP_CSA, BT_GA, BP_GA, Quay, LoW, BestCostSoFar_GA, fmin_CSA_cost, Time_CSA, Time_GA, BT_MILP_new, BP_MILP_new, Time_MILP);

% Function for seperate plots for each quay
%[x1]=Plots(BT_CSA, BP_CSA, BT_GA, BP_GA, Quay, LoW, BestCostSoFar_GA, fmin_CSA_cost, Time_CSA, Time_GA, BT_MILP_new, BP_MILP_new, Time_MILP);



% writematrix(BT_PSO, "D:\adnan\BT_PSO_90v15d2q.txt"); 
% writematrix(BP_PSO, "D:\adnan\BP_PSO_90v15d2q.txt"); 
% writematrix(BQ_PSO, "D:\adnan\BQ_PSO_90v15d2q.txt"); 
