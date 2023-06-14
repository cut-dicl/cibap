close all
clear 
clc

costs = 'costs.xlsx';  % calling the cost file
costs = readtable(costs,'Range','A1:K2'); 

%           TAKING DATA FROM EXCEL FILE
%AAAA = 'limassolMarch2019_2week.xlsx';  % calling the excell file for one week data
%DataTable = readtable(AAAA,'Range','A1:M29');    %% reading the table from excell file 
%%%%%%%%%%%%%%%%%%%%%%%%%%%


%       DATA GENERATING RANDOMLY
nnn=20; %prompt = 'Please state total number of ships? '; nnn = input(prompt);
days=2; %prompt = 'Please enter number of days/ planing period? '; days = input(prompt);
hours=days*24; %days multiply by hours in a day
quays=1; %prompt = 'Please enter number of Quays? '; quays = input(prompt);
[DataTable]=Instances_generator(nnn,hours, quays); % select this for random data


%           READING AND WRITING DATA COMMANDS
%DataTable=readstruct("C:\Users\sheraz.aslam\Dropbox\randomDataResults\data\30v2d2q.xml");
%writestruct(DataTable, "C:\Users\Sheraz\Dropbox\randomDataResults\data\120v15d3q.xml"); % write structure data
%BT_CSA = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\CSA\BT_CSA_150v30d5q.txt');

days=DataTable.days;
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
[PBQ ABQ]=PBP_PBQ_function(LoS, PBQ, data.AT, LoW); % PBQ and ABQ generation
data.ABQ=ABQ;
else
    data.ABQ=PBQ;
end

%%%%%%%%%%%%% ALGO 3  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CSA CODE HERE  %%%%%%%%%%%%%%%%%%%%%%%%%
algo=3;
tic
for n=1:1%noOfGeneration     
[BT BP BQ]=random_population(LoS, data.AT, data.dep, pTime, LoW, PBP, PBQ, populationSize); % random population generation

nest=[BT BP BQ];
[best_nest,fmin, nest, D,pa]=cuckoo_search(nest, noOfGeneration, n, data, LoW,costs);
bestnest(n,:)=best_nest;
MinobjValue(n)=fmin; 
    if n==1
        Convergance_CSA(n)=MinobjValue;
    elseif MinobjValue(n)>Convergance_CSA(n-1)
        Convergance_CSA(n)=MinobjValue(n);
    else
        Convergance_CSA(n)=Convergance_CSA(n-1);
    end
end
  Time_CSA=toc;
bestnest=[bestnest, MinobjValue']; % % adding fitness of each solution at the end
[j,k]=sort(bestnest(:,end),'descend'); % sorting from max to min and their loactions (index). e.g., j shows sorted values and k shows index of each value
bestnest=bestnest(k,:); % finding best nest through sorting
bestnest=bestnest(:,1:end-1);   % extra column (fitness value) is excluded from solutions
bestNest=bestnest(end,:); % last nest with minimum cost (fitness value) is considered best nest
fmin_CSA_cost=j(end) % to pick the last min value
BT_CSA=bestNest(1:length(bestNest)/3);
BP_CSA=bestNest(length(bestNest)/3+1:end-length(BT_CSA));
BQ_CSA=bestNest((length(bestNest)/3)*2+1:end);
[x1]=mainplot(BT_CSA, BP_CSA, data.pTime, data.LoS, algo,days*48); % plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Storing results in tex files                            %
% 
% writematrix(BT_CSA, "C:\Users\Sheraz\Dropbox\randomDataResults\CSA\BT_CSA_120v15d2q.txt"); 
% writematrix(BP_CSA, "C:\Users\Sheraz\Dropbox\randomDataResults\CSA\BP_CSA_120v15d2q.txt");
% writematrix(BQ_CSA, "C:\Users\Sheraz\Dropbox\randomDataResults\CSA\BQ_CSA_120v15d2q.txt");
% writematrix(fmin_CSA_cost, "C:\Users\Sheraz\Dropbox\randomDataResults\CSA\Cost_CSA_150v30d5q.txt");
% writematrix(Time_CSA, "C:\Users\Sheraz\Dropbox\randomDataResults\CSA\Time_CSA_15v1d1q.txt");
% writestruct(DataTable, "C:\Users\Sheraz\Dropbox\randomDataResults\data\15v1d1q.xml"); % write structure data that is generated randomly and will be used for all other algorithms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% the command thiat will read the saved data in form of structure
%%DataTable=readstruct("C:\Users\Sheraz\Dropbox\randomDataResults\data\10v1d1q.xml");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
