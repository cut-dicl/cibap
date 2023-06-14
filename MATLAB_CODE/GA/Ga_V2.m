function [finalSolution, BestCostSoFar_GA] = Ga_V2(populationSize,noOfGeneration,data, LoW,x,costs)

%%           Genatic Algorithm parameters initilization
corssOverPercentage=0.1; 
mutationPercentage=0.1; 
ElitesPercentage=0.1;
noOfCrossOvers=corssOverPercentage*populationSize;
noOFMutaion=mutationPercentage*populationSize;
noOfElites=ElitesPercentage*populationSize;
lambda=8;
PBQ_changed=[];

%%               Initial Population generation for GA
x;%x=[BT BP];  x contains initial random population

for iteration=1:1000%noOfGeneration 
    y=x;
    
    %individual fitness of the population
for i=1:populationSize 
[xFit(i,:), PBQ_changed, x, data]=getSchedule(x,LoW, data, iteration, i, PBQ_changed,costs);    % xFit shows cost f each solution set
end   
y=x;

    fitCumSum=cumsum(xFit); % Cumulative sum of elements. i.e., elements[1 3 5 6 7] result=[1 4 9 16 23]
    rouletteWheel=fitCumSum/fitCumSum(end);  %  it helps in parrent selection (divided by comulative number)
    y=[y,xFit]; % adding fitness of each solution
    [j,k]=sort(y(:,end),'descend'); % sorting from max to min and their loactions (index)
    y=y(k,:); % sort rows according to best solution (max to min)
    bestSolutionWithCost(iteration,:)=y(end,:); % it contains solution with cost
    bestCost(iteration)=j(end); % it contains only cost
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    % Parent Selection
    y=y(:,1:end-1);   % extra column (fitness value) is excluded from solutions
    for crindex=1:noOfCrossOvers % its not necessary to perform crossover multiple times.. u can do it only 1 time; however it depends on problem and solution
        ran=rand;
        for i=1:populationSize-1
            
            if (ran>rouletteWheel(i))
                parent1=x(i+1,:);
                parent1Index=i+1;                
            end
        end
        ran=rand;
        for i=1:populationSize-1
            if (ran>rouletteWheel(i) )
                parent2=x(i+1,:);
                parent2Index=i+1;                
            end
        end
         
    %%     
      %                Crossover
        children=crossoverRepair(parent1, parent2,lambda); % crossoverRepair fun is used to produce childs
        y(crindex+noOfElites,:)=children(1,:); % adding 1st child values in whole population
        y(crindex+noOfElites+1,:)=children(2,:);   % adding 2nd child values in whole population (different index)
    end
    %%
    
    %%                  Mutation
    for tm=1:noOFMutaion
        randPos=round(populationSize*rand);
        if randPos==0
            randPos=populationSize;
        end
        mutated=mutateSwap(y(randPos,:), data, LoW);
        y(noOfCrossOvers+noOfElites+tm,:)=mutated;
    end   
       %%
x=y;
bestCost;
iteration;

    if iteration==1 || iteration==100 || iteration==200 || iteration==300 || iteration==400 || iteration==500  || iteration==600 || iteration==700 || iteration==800 || iteration==900 || iteration==1000
    disp(['Iteration ' num2str(iteration) ': Best Cost = ' num2str(bestCost(end))]);
    end 
end 
[j,k]=sort(bestSolutionWithCost(:,end),'descend');
bestSolutionWithCost=bestSolutionWithCost(k,:); % sort rows according to best solution (max to min)
finalSolution=bestSolutionWithCost(end,1:end-1); % Best solution
BestCostSoFar_GA=bestSolutionWithCost(end,end)
