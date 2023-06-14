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
%writestruct(DataTable, "C:\Users\Sheraz\Dropbox\randomDataResults\data\150v30d2q.xml"); % write structure data
DataTable=readstruct("C:\Users\Sheraz\Dropbox\randomDataResults\data\10v1d1q.xml");




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
BT = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BT_MILP_10v1d1q.txt');
BP = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BP_MILP_10v1d1q.txt');
BQ = importdata('C:\Users\Sheraz\Dropbox\randomDataResults\MILP\BQ_MILP_10v1d1q.txt');
x=[BT BP BQ]; PBQ_changed=0;iii=1; iteration=1;

[Cost pos PBQ_changed data]= temp(data,x,LoW, iteration,iii,PBQ_changed);

%csa10=9766, 15=19554; 20=21922, 30=51922, 60=113284, 90=141270,
%120=199960, 150=232212

%ga10=9010, 15=25764, 20=19798, 30=40356, 60=97166, 90=144874, 120= 313522,
%150=347668====toatal 998158

%pso10=24678, 15=45652, 20=39614, 30=37336, 60=105444, 90=149536,
%120=245614, 150= 229326