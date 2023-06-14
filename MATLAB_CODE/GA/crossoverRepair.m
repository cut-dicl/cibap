function [children]=crossoverRepair(parent1, parent2,lambda)

   
%%%%%%%%%%%%%%%%%%%%%%%%% 
parent1BAP=parent1;%(1:2*length(arrivalTime));
parent2BAP=parent2;%(1:2*length(arrivalTime));

rand=randperm( length(parent1BAP));
rand=rand(1:2);
rand1=rand(1);
rand2=rand(2);
  if rand1>rand2   
      temprand=rand1;
      rand1=rand2 ;
      rand2= temprand ;
  end
  
parent3=parent1BAP(rand1+1:rand2); 
parent4=parent2BAP(rand1+1:rand2);

for i=1:length(parent3) 
    for j=1:length(parent4)
        if i==j
        a(i,j)=floor((lambda*parent3(i)+(1-lambda)*parent4(j)));
        b(i,j)=floor((lambda*parent4(i)+(1-lambda)*parent3(j)));
        end
    end
end 
child1=[parent1BAP(1:rand1) diag(a)' parent1BAP(rand2+1:end)];
child2=[parent2BAP(1:rand1) diag(b)' parent2BAP(rand2+1:end)];
childrenBAP=[child1;child2] ;

children=childrenBAP;