function [price2, All_prices, totalsize]=price2calculate(p2,n, Quay,All_prices,totalsize)
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%            MAIN AREA for all QUAYS
    price2=[];
       % calculating cost against all posible berthing positions
    for i=1:size(p2, 1) 
        if p2(i, 1)==1 %Quay.LoS1(n)
            price2(i)=2;
        else 
          price2(i)=5;
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   adding penalties in case of everlaping
    if n>1
        pp=n-1;
        maxprice=0;
        for iii=1:n-1
            %               avoiding overlappin constraints... checking
            %               each ship with all other ships
if (Quay.AT1(n)<=Quay.AT1(pp) && Quay.dep1(n)>Quay.AT1(pp))|| (Quay.AT1(n)>Quay.AT1(pp) && Quay.dep1(pp)>Quay.AT1(n))
    
    previousprice=All_prices(sum(totalsize(1:pp-1))+1: sum(totalsize(1:pp))); % price of previous ship n-1
    minPositionPrevious=find(previousprice==min(previousprice)); % minimum price position for previous ship n-1 or pp
    %maxprice=maxprice+Quay.LoS1(pp);
    minprice(iii)=minPositionPrevious+Quay.LoS1(pp);
    maxprice=max(minprice);
    
    price2(1:maxprice)=8;
    price2(maxprice+1)=1;
    
end
pp=pp-1;
%minprice
end % for ends iii
end %if ends 
All_prices=[All_prices price2]; % need to write function for clear price2 calculation
totalsize(n)=length(price2);