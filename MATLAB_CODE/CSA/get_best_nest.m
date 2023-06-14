
%% Find the current best nest
function [fmin, bestNest, nest, fitness1, data,PBQ_changed]=get_best_nest(nest,newnest,fitness, data, lengthOfwharf,iteration,PBQ_changed,costs)

nest=newnest;

totalShips=length(data.AT);
BT=nest(:,1:totalShips);
BP=nest(:,totalShips+1:totalShips*2);
BQ=nest(:,totalShips*2+1:end);
%%%%%%%%%%%%%%
BT11=BT; BP11=BP; BQ11=BQ;
AT=data.AT; departure=data.dep; LoS=data.LoS; LoW=lengthOfwharf; PBQ=data.PBQ; pTime=data.pTime; ABQ=data.ABQ;
PBP=data.PBP;

for iii=1:length(nest(:,1)) %           MAIN LOOP STARTS HERE
ShipNo_BQChange=[]; x=0; sum_ships=[]; Ship_search_space_jump=[]; y=0; m=0;

BP=BP11(iii,:);
BT=BT11(iii,:);
BQ=BQ11(iii,:);
penalty0=0; penalty1=0; penalty2=0; penalty3=0; penalty4=0;penalty_SET=0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       avoiding berth assignment before ETA or after ETD                 %
% requested departure time
for i=1:length(AT) 
    if BT(i)<AT(i) || BT(i)>departure(i)
        %BT(i)=randi([arrivalTime(i),departure(i)-pTime(i)+2]);
        penalty0=penalty0+costs.Pen_berth_before_ETA; %100000;
    end
end
all_penalty0(iii)=penalty0;

%           WAITING TIME and COST
WaitingTime=abs(BT-AT); % calculating waiting time here bb is arrival times
WaitingCost=sum(WaitingTime)*(costs.Waiting_C/2);% 10; % waiting cost based on 20euro per hour




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%         NEW OVERLAPING AREA             %%%%%%%%%%%%%%%%
        for a=1:length(AT)
         if BP(a)+LoS(a)>sum(LoW(1:PBQ(a))) %LoW(PBQ(a))
            penalty1=penalty1+costs.Pen_wharf_length_cross; %10000; % wharf length cross penalty
            %a
         end
            for b=1:length(AT)
                 if a~=b
             if (BP(b)>= BP(a) && BP(b) <= BP(a)+LoS(a)) || (BP(a)>= BP(b) && BP(a) <= BP(b)+LoS(b)) % (2) berthing position j greater ho BP i s and BP(j) agr lesser ho BP(I)+LoS(i). it is used to avoid overlaping
                if (BT(a)<=BT(b) && BT(a)+pTime(a)>BT(b)) || (BT(b)<=BT(a) && BT(b)+pTime(b)>BT(a))...
                        || (BT(a)>=BT(b) && BT(a)<BT(b)+pTime(b)) || (BT(b)>=BT(a) && BT(b)<BT(a)+pTime(a))
                    penalty2=penalty2+costs.Overlapping_C; %5000; %overlapping penalty
                            if iteration>400 && iteration<450% && iii %&& a+b~=sum_ships
                               if   any(a+b==sum_ships)==false
                                    y=y+1; m=m+1;
                                    Ship_search_space_jump(y)=b;
                                    y=y+1;
                                    Ship_search_space_jump(y)=a;
                                    sum_ships(m)=a+b;
                                end
                            end %               IF ENDs HERE

                            if iteration>450 && PBQ(b)~=ABQ(b) && iii ==1 % 
                                x=x+1;
                                ShipNo_BQChange(x)=b;
                            end
                end
            end
                 end
            end
        end
      
        %    cHANGING bq of ship 6 to ABQ
        %ss=notmember(1, PBQ_changed);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                 CHANGING BP of overlaping ships on the smae  BQ
        if Ship_search_space_jump >=1
            [BT BP_jumped]=Jump_places_overlapig(Ship_search_space_jump, iii,pTime, AT, ABQ, BQ, LoS, PBP, PBQ, BT, BP,lengthOfwharf);
            BP11(iii+1,:)=BP_jumped;
            BT11(iii+1,:)=BT;
            BQ11(iii+1,:)=BQ;
            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
      if ShipNo_BQChange>=1
       if rem(length(ShipNo_BQChange),2)==0
           for i=1:length(ShipNo_BQChange)
            if rem(i,2)==0   
                if any(ShipNo_BQChange(i)==PBQ_changed)==false % || PBQ_changed ==[] %==false % any(ShipNo_BQChange(1)~=PBQ_changed(1))==true %ShipNo_BQChange~=1......any(1)~=1==true
                if any(ShipNo_BQChange(i-1)==PBQ_changed)==false    
                    % b=randi([1,2]);            %[minnn, Index]=min(LoS(ShipNo_BQChange(1)), LoS(ShipNo_BQChange(2)));
                    pp=[ShipNo_BQChange(i-1) ShipNo_BQChange(i)]; %% pp contains two overlaping ships and one of them needs to change its BQ
                    [min_pTime, b]=min(pTime(pp)); % finding max time and location
                    BP(pp(b))= randi([sum(lengthOfwharf(1:ABQ(pp(b))-1)), sum(lengthOfwharf(1:ABQ(pp(b))))-LoS(pp(b))]);
                    BQ(pp(b))=ABQ(pp(b));
                    PBQ(pp(b))=ABQ(pp(b));
                    PBP(pp(b))= randi([sum(lengthOfwharf(1:ABQ(pp(b))-1)), sum(lengthOfwharf(1:ABQ(pp(b))))-LoS(pp(b))]); %BP(ShipNo_BQChange(b));
                    % adding new bp and bq in the population
                    BP11(iii,:)=BP;
                    BT11(iii,:)=BT;
                    BQ11(iii,:)=BQ;
                    nest(iii,:)=[BT BP BQ];
                    PBQ_changed=[PBQ_changed pp(b)];
                end
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
        penalty_SET=penalty_SET+costs.Pen_Set; %10000;
        %i
        %j
        end
        end
    end
end
all_penalty_SET(iii)=penalty_SET;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Preferred berthing quay and position penalty
for i=1:length(AT) 
    if BQ(i)==ABQ(i) && ABQ(i)~=3 % if proposed quay is ABQ, a fixed penalty is added
        pen=costs.Pen_ifABQ; %200;
    elseif  BQ(i)==PBQ(i) % if proposed quay id preferred quay penalty maybe 0 or defined based on preferred berthing position
        pen=(abs(BP(i)-PBP(i)))*5;
    else % if proposed quay is neither preferred not ABQ, an infinite penalty is added
        pen=costs.Pen_no_ABQ_no_PBQ; %100000;
    end
penalty3=penalty3+pen;
end

all_penalty3(iii)=penalty3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%% HANDLING time and costs

HandlingTime=sum(pTime);
HandlingCost=(HandlingTime-length(AT))*(costs.Handling_C/2); %10; % we have assumed 10eur per hour handling cost and here unit is for 30min

 
%       this area of code is used for checking early or late departures
lateDeparture=zeros(1,length(departure));
earlyDeparture=zeros(1,length(departure));
for i=1:length(departure)
lateDeparture(i)= (BT(i)+pTime(i))-departure(i);
if lateDeparture(i)<0 ; earlyDeparture(i)=abs(lateDeparture(i));  lateDeparture(i)=0; end
end
totalLateTime=sum(lateDeparture);
totalLateCost=totalLateTime*(costs.Latedeparture_C/2); %20;% intitially we assumed 20euro penallty against each late hour (LAST PART of EQUATION 1)
totalEarly=sum(earlyDeparture);


totalCompletionTime=(totalLateTime+sum(pTime)+penalty2);
Cost=WaitingCost+HandlingCost+penalty0+totalLateCost+penalty1+penalty2+penalty3+penalty_SET;

cost1(iii,:)=Cost;
fitness1(iii,:)=1/(totalCompletionTime);



nest(iii,:)=[BT BP BQ];
end

data.ABQ=ABQ;
data.PBQ=PBQ;
data.PBP=PBP;

nest=[nest, cost1]; % % adding fitness of each solution at the end
[j,k]=sort(nest(:,end),'ascend');% 'descend'); % sorting from max to min and their loactions (index). e.g., j shows sorted values and k shows index of each value
nest=nest(k,:); % finding best nest through sorting
nest=nest(:,1:end-1);   % extra column (fitness value) is excluded from solutions
bestNest=nest(1,:); % first nest with highest fitness value is considered best nest
nest=newnest;
fmin=j(1);