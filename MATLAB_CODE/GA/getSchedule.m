function [Cost, PBQ_changed, pop, data] = getSchedule(pop,LoW, data, iteration, iii, PBQ_changed,costs)
x=pop(iii,:);
ShipNo_BQChange=[]; xx=0; sum_ships=[]; Ship_search_space_jump=[]; y=0; m=0;
penalty0=0; penalty1=0; penalty2=0; penalty3=0; penalty4=0; penalty5_PBQ=0; penalty_SET=0;

BT=x(1:length(x)/3); % for picking first three values from x as berthing times
BP=x(length(x)/3+1:length(BT)*2);  % for picking 4-6 index values from x as berthing positions
BQ=x(length(BT)*2+1:end);
lengthOfwharf=LoW; % lengths of berthing quays
AT=data.AT;
pTime=data.pTime;
Departure=data.dep;
LoS=data.LoS;
PBQ=data.PBQ;
PBP=data.PBP;
ABQ=data.ABQ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       avoiding berth assignment before ETA after ETD                 %
% requested departure time
for i=1:length(AT) 
    if BT(i)<AT(i) || BT(i)>Departure(i)
        penalty0=penalty0+costs.Pen_berth_before_ETA; %. 10000;
    end
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           WAITING TIME and COST
WaitingTime=abs(BT-AT); % calculating waiting time
WaitingCost=sum(WaitingTime)*(costs.Waiting_C/2); %10; % waiting cost based on 20euro per hour


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%         NEW OVERLAPING AREA             %%%%%%%%%%%%%%%%

for a=1:length(AT)
            for b=1:length(AT)
                 if a~=b
                    if BP(a)+LoS(a)>=sum(LoW(1:PBQ(a)))%LoW(PBQ(a)) % this constraint ensures that the length of ship + berthing position must be less than length of wharf
                        penalty1=penalty1+costs.Pen_wharf_length_cross; %10000;
                    end
                    
             if (BP(b)>= BP(a) && BP(b) <= BP(a)+LoS(a)) || (BP(a)>= BP(b) && BP(a) <= BP(b)+LoS(b)) % (2) berthing position j greater ho BP i s and BP(j) agr lesser ho BP(I)+LoS(i). it is used to avoid overlaping
                
                if (BT(a)<=BT(b) && BT(a)+pTime(a)>BT(b)) || (BT(b)<=BT(a) && BT(b)+pTime(b)>BT(a))...
                        || (BT(a)>=BT(b) && BT(a)<BT(b)+pTime(b)) || (BT(b)>=BT(a) && BT(b)<BT(a)+pTime(a))
                    penalty2=penalty2+costs.Overlapping_C; %5000; %overlapping penalty
                    if iteration>400 && iteration<450% && iii ==1%&& a+b~=sum_ships
                               if   any(a+b==sum_ships)==false
                                    y=y+1; m=m+1;
                                    Ship_search_space_jump(y)=b;
                                    y=y+1;
                                    Ship_search_space_jump(y)=a;
                                    sum_ships(m)=a+b;
                                end
                    end %               IF ENDs HERE

                        if iteration>450 && PBQ(b)~=ABQ(b) && iii ==1 % 
                                xx=xx+1;
                                ShipNo_BQChange(xx)=b;
                        end
                end
            end
                 end
            end
end           % OVERLAPING CONSTRAINTS END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %                 CHANGING BP of overlaping ships on the smae  BQ
        if Ship_search_space_jump >=1
            [BT BP_jumped]=Jump_places_overlapig(Ship_search_space_jump, iii,pTime, AT, ABQ, BQ, LoS, PBP, PBQ, BT, BP,lengthOfwharf);
            if iii<100
                pop(iii+1,:)=[BT BP_jumped BQ];
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  New Area for adjusting overlapping issue and modifying BQ and PBQ to ABQ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                    pop(iii+1,:)=[BT BP BQ];
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
        penalty_SET=penalty_SET+costs.Pen_Set;% 10000;
        end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Preferred berthing quay anf position penalty
for i=1:length(AT) 
if BQ(i)==ABQ(i) % if proposed quay is ABQ, a fixed penalty is added
    pen=costs.Pen_ifABQ; %50;
elseif  BQ(i)==PBQ(i) % if proposed quay id preferred quay penalty maybe 0 or defined based on preferred berthing position
    pen=(abs(BP(i)-PBP(i)))*5;
else % if proposed quay is neither preferred not ABQ, an infinite penalty is added
    pen=costs.Pen_no_ABQ_no_PBQ; %100000;
end
penalty3=penalty3+pen;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%% HANDLING time and costs

HandlingTime=sum(pTime); % dd is handling time
HandlingCost=HandlingTime*(costs.Handling_C/2); %5; % we have assumed 10eur per hour handling cost and here unit is for 30min

 
%       this area of code is used for checking early or late departures
lateDeparture=zeros(1,length(AT));
earlyDeparture=zeros(1,length(AT));
for i=1:length(AT)
lateDeparture(i)= (BT(i)+pTime(i))-Departure(i); % cc is a departure time
if lateDeparture(i)<0 ; earlyDeparture(i)=abs(lateDeparture(i));  lateDeparture(i)=0; end
end
totalLateTime=sum(lateDeparture);
totalLateCost=totalLateTime*(costs.Latedeparture_C/2); %20;% intitially we assumed 20euro penallty against each late hour (LAST PART of EQUATION 1)

totalEarly=sum(earlyDeparture);

data.ABQ=ABQ;
data.PBQ=PBQ;
data.PBP=PBP;
Cost=WaitingCost+HandlingCost+totalLateCost+penalty0+penalty1+penalty2+penalty3+penalty4+penalty_SET;
Xx=[BT BP BQ]; %Xx is solution set