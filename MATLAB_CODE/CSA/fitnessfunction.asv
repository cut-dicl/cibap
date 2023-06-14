function [Cost pos] = fitnessfuction(data,x,LoW)
departure=data.dep; AT=data.AT; LoS=data.LoS; PBQ=data.PBQ; pTime=data.pTime; ABQ=data.ABQ; PBP=data.PBP;

penalty0=0; penalty1=0; penalty2=0; penalty3=0; penalty4=0; penalty5_PBQ=0; penalty_SET=0;

BT=x(1:length(AT)); % for picking first values from x as berthing times
BP=x(length(BT)+1:length(x)-length(BT));  % for picking values from x as berthing positions
BQ=x(length(BT)+length(BP)+1:end);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       avoiding berth assignment before ETA after ETD                 %
% requested departure time
for i=1:length(AT) 
    if BT(i)<AT(i) || BT(i)>departure(i)
        penalty0=penalty0+100000;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%           WAITING TIME and COST
WaitingTime=abs(BT-AT); % calculating waiting time
WaitingCost=sum(WaitingTime)*10; % waiting cost based on 20euro per hour




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%         NEW OVERLAPING AREA             %%%%%%%%%%%%%%%%
        for a=1:length(AT)
            for b=1:length(AT)
                 if a~=b
                    if BP(a)+LoS(a)>sum(LoW(1:PBQ(a))) %LoW(PBQ(a))
                        penalty1=penalty1+10000; % wharf length cross penalty
                    end
                    
             if (BP(b)>= BP(a) && BP(b) <= BP(a)+LoS(a)) || (BP(a)>= BP(b) && BP(a) <= BP(b)+LoS(b)) % (2) berthing position j greater ho BP i s and BP(j) agr lesser ho BP(I)+LoS(i). it is used to avoid overlaping
                if (BT(a)<=BT(b) && BT(a)+pTime(a)>BT(b)) || (BT(b)<=BT(a) && BT(b)+pTime(b)>BT(a))...
                        || (BT(a)>=BT(b) && BT(a)<BT(b)+pTime(b)) || (BT(b)>=BT(a) && BT(b)<BT(a)+pTime(a))
                    penalty2=penalty2+5000; %overlapping penalty
                end
            end
                 end
            end
        end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   safety entrance time (SET) || avoid multiple entrance in single time      %
for i=1:length(AT) 
    for j=1:length(AT) 
        if j~=i
        if BT(i)==BT(j)
        penalty_SET=penalty_SET+10000;
        end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Preferred berthing quay and position penalty
for i=1:length(AT) 
if BQ(i)==ABQ(i) % if proposed quay is ABQ, a fixed penalty is added
    pen=200;
elseif  BQ(i)==PBQ(i) % if proposed quay id preferred quay penalty maybe 0 or defined based on preferred berthing position
    pen=(abs(BP(i)-PBP(i)))*2;
else % if proposed quay is neither preferred not ABQ, an infinite penalty is added
    pen=100000;
    BQ(i)=randi([min(PBQ(i),ABQ(i)), max(PBQ(i),ABQ(i))]);
end
penalty3=penalty3+pen;
end


%%%%%%%%%%%%%%%%%%%%%%%%%% HANDLING time and costs

HandlingTime=sum(pTime);
HandlingCost=HandlingTime*5; % we have assumed 10eur per hour handling cost and here unit is for 30min

  
%       this area of code is used for checking early or late departures
lateDeparture=zeros(1,length(departure));
earlyDeparture=zeros(1,length(departure));
for i=1:length(departure)
lateDeparture(i)= (BT(i)+pTime(i))-departure(i);
if lateDeparture(i)<0 ; earlyDeparture(i)=abs(lateDeparture(i));  lateDeparture(i)=0; end
end
totalLateTime=sum(lateDeparture);
totalLateCost=totalLateTime*20;% intitially we assumed 20euro penallty against each late hour (LAST PART of EQUATION 1)
totalEarly=sum(earlyDeparture);

totalCompletionTime=(totalLateTime+sum(pTime)+penalty2);

fitness=1/totalCompletionTime;
Cost=WaitingCost+HandlingCost+penalty0+penalty3+totalLateCost+penalty1+penalty2+penalty4+penalty_SET;
pos=[BT BP BQ];