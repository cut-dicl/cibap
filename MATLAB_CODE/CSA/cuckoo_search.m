% 2) X.-S. Yang, S. Deb, Engineering optimization by cuckoo search,
% Int. J. Mathematical Modelling and Numerical Optimisation, 
% Vol. 1, No. 4, 330-343 (2010). 
% http://arxiv.org/PS_cache/arxiv/pdf/1005/1005.2908v2.pdf


function [bestNest_so_Far,min_ObjVal, nest, D, pa]=cuckoo_search(nest, noOfGeneration, n, data, LoW,costs) %this function ends on line 97
% Number of nests (or different solutions)
n=noOfGeneration;
%Nn=50;
D=138;
%%%%%%%%%%%%%%%
% Discovery rate of alien eggs/solutions
pa=0.45;

%% Change this if you want to get better results
% Tolerance
Tol=1000;
%% Simple bounds of the search domain
% % Lower bounds
nd=D; 
 Lb=-5*ones(1,nd); 
% % Upper bounds
 Ub=5*ones(1,nd);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count =1;
nest1=nest;

% Get the current best
fitness=10^10*ones(n,1); % intialize a vector to save the fitness value of nests

%%%%%%%%%%%%%%%%%%%############### FIRST STEP select the best nest
PBQ_changed=[];
%[cost]=qqq(Quay, LoW);
[fmin, bestNest, nest, fitness1, data,PBQ_changed]=get_best_nest(nest,nest1,fitness, data, LoW,count,PBQ_changed,costs);

%[x1]=mainplot(bestNest(1:length(data.LoS)), bestNest(length(data.LoS)+1:length(data.LoS)*2), data.pTime, data.LoS, 3,48); % plot

%% Starting iterations

while (count<=Tol)%,

%%%%%%%%%%%%%%%%%%%############### SECOND STEP generete new solutions
    % Generate new solutions (but keep the current best)
     new_nest=get_cuckoos(nest,bestNest,data,LoW,PBQ_changed);   
     
     [fnew1,best1,nest,fitness, data,PBQ_changed]=get_best_nest(nest,new_nest,fitness, data, LoW,count,PBQ_changed,costs);
    % Update the counter

      
      
    % Discovery and randomization
      new_nest=empty_nests(nest,best1,Lb,Ub,pa,data) ; 
    
    % Evaluate this set of solutions
     [fnew2,best2,nest,fitness, data,PBQ_changed]=get_best_nest(nest,new_nest,fitness, data, LoW,count,PBQ_changed,costs);
      fnew2;
    % Update the counter again
   
      
    % Find the best objective so far  
    [min_ObjVal, bestNest_so_Far]= calculateMinValue(fmin,fnew1,fnew2,bestNest,best1,best2);
    bestNest=bestNest_so_Far;
    
    if count==1 || count==100 || count==200 || count==300 || count==400 || count==500  || count==600 || count==700 || count==800 || count==900 || count==1000
    disp(['Iteration ' num2str(count) ': Best Cost = ' num2str(min_ObjVal)]);
    end 
   count=count+1;     
end %% End of iterations

%% Post-optimization processing
%% Display all the nests
% disp(strcat('Total number of iterations=',num2str(N_iter)));
fmin;
bestNest;

%% --------------- All subfunctions are list below ------------------

%% Replace some nests by constructing new solutions/nests
function new_nest=empty_nests(nest,best1,Lb,Ub,pa,data)
% A fraction of worse nests are discovered with a probability pa
n=size(nest,1);
% Discovered or not -- a status vector
AT=data.AT;

% In the real world, if a cuckoo's egg is very similar to a host's eggs, then 
% this cuckoo's egg is less likely to be discovered, thus the fitness should 
% be related to the difference in solutions.  Therefore, it is a good idea 
% to do a random walk in a biased way with some random step sizes.  
%% New solution by biased/selective random walks


for j=1:n
     BT_newNest=0;
     BP_newNest=0;
     BQ_newNest=0;
if rand<pa
       
       for i=1:length(AT)
           BT_newNest(i)=randi([AT(i), best1(i)]);
           %BP_newNest(i)=randi([data.PBP(i), min(best1(length(AT)+i), nest(length(AT)+i) )]);
           BP_newNest(i)=randi([round((nest(j,length(AT)+i)+best1(length(AT)+i))/2), max(nest(j,length(AT)+i), best1(length(AT)+i))]);
           BQ_newNest(i)=randi([1,5]);
       end
        %new_nest(j,:)=[round((b-a).*rand(1,size(PBP,2))+a) round((d-c).*rand(1,size(PBP,2))+c)];
        new_nest(j,:)=[BT_newNest BP_newNest BQ_newNest];

else
    new_nest(j,:)=nest(j,:);
end  

 if j==1          % for keeping previous best
       new_nest(j,:)=best1;
 end
end


% Application of simple constraints
function s=simplebounds(s,Lb,Ub)
  % Apply the lower bound
  ns_tmp=s;
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);
  
  % Apply the upper bounds 
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
  % Update this new move 
  s=ns_tmp;
