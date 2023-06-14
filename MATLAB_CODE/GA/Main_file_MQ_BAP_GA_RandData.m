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
%DataTable=readstruct("C:\Users\Sheraz\Dropbox\randomDataResults\data\150v30d5q.xml");




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


%%%%%%%%%%%%% ALGO 2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   CODE of GA ALGORITHM HERE  %%%%%%%%%%%%%%%%%%
algo=2;
[BT BP BQ]=random_population(LoS, data.AT, data.dep, pTime, LoW, PBP, PBQ, populationSize); % random population generation
x=[BT BP BQ];
tic
[finalSolution_GA, BestCostSoFar_GA]=Ga_V2(populationSize, noOfGeneration, data, LoW, x,costs);
BT_GA=finalSolution_GA(1:length(finalSolution_GA)/3);
BP_GA=finalSolution_GA(length(BT_GA)+1:end-length(BT_GA));
BQ_GA=finalSolution_GA(length(BT_GA)*2+1:end);
Time_GA=toc;
[x1]=mainplot(BT_GA, BP_GA, data.pTime, data.LoS, algo,1440); % plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Storing results in tex files                            %

% writematrix(BT_GA, "C:\Users\Sheraz\Dropbox\randomDataResults\GA\BT_GA_150v30d5q.txt"); 
% writematrix(BP_GA, "C:\Users\Sheraz\Dropbox\randomDataResults\GA\BP_GA_150v30d5q.txt");
% writematrix(BQ_GA, "C:\Users\Sheraz\Dropbox\randomDataResults\GA\BQ_GA_150v30d5q.txt");
% writematrix(Time_GA, "C:\Users\Sheraz\Dropbox\randomDataResults\GA\Time_GA_150v30d5q.txt");
% writematrix(BestCostSoFar_GA, "C:\Users\Sheraz\Dropbox\randomDataResults\GA\Cost_GA_150v30d5q.txt");
