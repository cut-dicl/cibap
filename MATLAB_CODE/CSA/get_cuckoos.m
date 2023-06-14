%% Get cuckoos by ramdom walk
function new_nest=get_cuckoos(nest,best, data,LoW,PBQ_changed)
AT=data.AT; PBP=data.PBP; dep=data.dep; pTime=data.pTime; PBQ=data.PBQ; LoS=data.LoS; ABQ=data.ABQ;
% Levy flights
n=size(nest,1);
% Levy exponent and coefficient
% For details, see equation (2.21), Page 16 (chapter 2) of the book
% X. S. Yang, Nature-Inspired Metaheuristic Algorithms, 2nd Edition, Luniver Press, (2010).
beta=3/2;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);

for j=1:n%,
if j>1 && rand>0.5
    BT=new_nest(j-1,1:size(nest,2)/3); % storing first 28 values in BT
    BP=new_nest(j-1,size(BT,2)+1:size(BT,2)*2); % storing last 28 values in BP
    BQ=new_nest(j-1,size(BT,2)+size(BP,2)+1:end); % storing last 28 values in BP
else
    BT=best(1:size(nest,2)/3); % storing first 28 values in BT
    BP=best(size(BT,2)+1:size(BT,2)*2); % storing last 28 values in BP
    BQ=best(size(BT,2)+size(BP,2)+1:end); % storing last 28 values in BP
end
    % This is a simple way of implementing Levy flights
    % For standard random walks, use step=1;
    %% Levy flights by Mantegna's algorithm
    u=randn(size(BT))*sigma;
    v=randn(size(BP))*-10;
    x=randn(size(BQ))*beta;
    step=u./abs(v).^(1/beta)*60;
    %step2=abs(u./abs(v).^(1/beta)*10); % avoid neg - values to avoid BT before AT
  
    % In the next equation, the difference factor (s-best) means that 
    % when the solution is the best solution, it remains unchanged.     
    
    %stepsize= (ones(size(BT)))/4;%0.01*step.*(s-best);

    stepsize= (ones(size(BT)))/4;%0.01*step.*(s-best);

    % Here the factor 0.01 comes from the fact that L/100 should the typical
    % step size of walks/flights where L is the typical lenghtscale; 
    % otherwise, Levy flights may become too aggresive/efficient, 
    % which makes new solutions (even) jump out side of the design domain 
    % (and thus wasting evaluations).
    % Now the actual random walks or flights

    %BT=round(BT+(stepsize.*randn(size(BT))));
    %BP=round(BP+stepsize.*randn(size(BP)));
    %BQ=round(BQ+stepsize.*randn(size(BQ)));
    
    new_BQ=BQ;
    new_BP=round(BP+step.*randn(size(BP)));
    %new_BT=round(BT+step2.*randn(size(BT)));
    
    for i=1:length(BT)
    new_BT(i)=max(round((round(BT(i)+u(i)+step(i))+AT(i))/2), AT(i)+3);
        %new_BP(i)=randi([min(PBP(i),round(BP(i)-v(i)-step(i))), max(PBP(i),round(BP(i)+v(i)+step(i))) ]) ;
    
    if new_BT(i)>dep(i)-pTime(i)
        new_BT(i)=randi([AT(i),max(AT(i),dep(i)-pTime(i))]);
    end

    if new_BP(i)<sum(LoW(1:PBQ(i)-1))
    new_BP(i)=sum(LoW(1:PBQ(i)-1))+1; % avoiding negative berthing position
    end
        if new_BP(i)> sum(LoW(1:PBQ(i)))-LoS(i) % avoiding crossing the length of wharf
            new_BP(i)=randi([min(BP(i),PBP(i)), max(BP(i),PBP(i))]);
        end

    if PBQ_changed~=0 % adding new BP for changed BQ randomly because there is not PBP
        if i==PBQ_changed 
        new_BP(i)=randi([sum(LoW(1:PBQ(i)-1)), sum(LoW(1:PBQ(i)))-data.LoS(i)]);
        end
    end

    if BQ(i)~= PBQ(i)
    new_BQ(i)=randi([min(ABQ(i),PBQ(i)), max(ABQ(i),PBQ(i))]); %abs(round(BQ(i)+x(i)));
    end
    end
    
    
    %new_BQ=abs(round(BQ+x+step)); BQ(BQ>5)=randi([1,5]); BQ(BQ==0)=randi([1,5]);
    
       % Apply simple bounds/limits
   %nest(j,:)=simplebounds(s1,Lb,Ub);
   if j==1          % for keeping previous best
       new_nest(j,:)=best;
   else
   new_nest(j,:)=[new_BT new_BP new_BQ]; % s1 shows berthing times, s2 denotes berthing positions, and s3 is used for sequence of tasks.
   end
end