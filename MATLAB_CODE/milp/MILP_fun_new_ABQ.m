function [pricenew, hourMatrix] = MILP_fun_new_ABQ(data,LoW,totalSlots,n)
WharfLength=LoW;
minHours = data.pTime(n); %ShipsTable.ProcessingTimeOfVessel(n);
    maxHours = data.pTime(n);
    hourMatrix = [];
   for hours = minHours:maxHours % ...generate all possible solutions
        hourVector = zeros(1,totalSlots); % we have done simulations for 168 hours/ (but 30-min interval) one week
        hourVector(1:hours) = 1; %%% in first row and hours coloumns is = 1
       
nn = length(hourVector);
m = data.pTime(n); % processing time of vessels
LoV=data.LoS(n); % length of vessel
%i0 = nchoosek(1:nn,m);
[p]=combsCont(nn,m);    % possible solution based on hour
[p2]=combsCont(LoW(data.PBQ(n)),LoV);    % possible solution based on berthing locations, length of ship, and preferred berthing quays
[p22]=[p2];
if data.PBQ(n)>1; [p2]=[p2]+sum(LoW(1:data.PBQ(n)-1)); end
i0=[p];
s = size(i0,1); out = zeros(s,nn); ii = bsxfun(@plus,(i0 - 1)*s,(1:s)'); out(ii) = 1;
newHourMatrix=out';
hourMatrix = [hourMatrix newHourMatrix];

%%%%%%%%%%%%%%%%%%%%%%

% new hour matrix calculation
bbb=[];
for bb=1:size(hourMatrix,2)
    aaa=[];
for cc=1:size(p2, 1)
    hr=hourMatrix(:,bb); loc1=p2(cc,:)';
aa=[hr
 loc1];
aaa=[aaa aa];
end
bbb=[bbb aaa];
end
newHourMatrix=bbb;
hourMatrix=[];
hourMatrix = [hourMatrix newHourMatrix];

   end
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %            PRICE CALCULATING AREA
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   % calculating cost against all posible berthing times
   %for i=1:numvess
   price1=[];
    for b=1:size(p,1)
            if p(b,1)==data.AT(n) %&& ismember(p(b,1),[BT_MILP_new])<1 % this condition follow safety entrance constraint. the price is less only if it follows SET rule I WILL CHECK THIS AGAIN
                price1(b)=2; % this is feasible time with no waiting no late departure
            elseif p(b,1)>data.AT(n) && (p(b,1)+data.pTime(n)-1)<=data.dep(n)
                %elseif p(b,1)>Quay.AT1(n) && (p(b,1)+ShipsTable.ProcessingTimeOfVessel(n)-1)<=Quay.dep1(n)
                price1(b)=3; % the cost is increased because of waiting time but no late departure
            else
                price1(b)=5; % high cost because of late departure 
            end
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%         FUNCTION for price2 calculation\                         %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%i have used these two lines with function for conf version of multi-quay
%[price2, All_prices, totalsize]=price2calculate(p2,n, data,All_prices,totalsize);
%price2=price2(1:size(p2, 1)); % sometimes constraint increases then the total prices. this problem exists in ship 14..to solve this, I have added  this line extra
price2=[];
       % calculating cost against all posible berthing positions
    for i=1:size(p2, 1) 
        if p2(i, 1)==data.PBP(n)
            price2(i)=2;
        else 
            %price2(i)=5;
            price2(i)=2+abs(data.PBP(n)-p2(i, 1))*2; %10/WT;
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Adding penalties in case of everlaping                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if n>1
pp=n-1;
  for iii=1:n-1
        if (data.AT(n)<=data.AT(pp)||...
            (data.AT(n)>=data.AT(pp) && data.AT(n)<data.dep(pp)))&&...
            data.AT(n)+data.pTime(n)>data.AT(pp)
    
                if (data.PBP(n)>=data.PBP(pp)...
                    && data.PBP(n)<data.PBP(pp)+data.LoS(pp))...
                    || data.PBP(n)<=data.PBP(pp) && data.PBP(n)+data.LoS(n)>data.PBP(pp)
                    %penality here
                    price2( max( (max(sum(WharfLength(1:data.PBQ(n)-1)), data.PBP(pp)-(data.LoS(n)+2))) ...
                    -sum(WharfLength(1:data.PBQ(n)-1)), 1): ... %
                    min( (data.PBP(pp)+data.LoS(pp)+2)-sum(WharfLength(1:data.PBQ(n)-1)), length(price2)) )=2000;         

                    data.PBP(n)=sum(WharfLength(1:data.PBQ(n)-1))+find(price2 == min(price2)); % adding new PBP due to overlaping
                end
        end
pp=pp-1;
  %% 
  end % for ends iii
end %if ends

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%% Adding penality if vessel exceeds the max wharf  %%%%%%%%%
    for kk=1:length(p2) 
        if p2(kk)+data.LoS(n)>= sum(LoW(1:data.PBQ(n)))
            price2(kk)=2000;
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
      
    %       new area
    pricenew=[];price=[];
    for i=1:length(price1)
        for j=1:length(price2)
            price(j)=price1(i)*price2(j);
        end
        pricenew=[pricenew price];
    end