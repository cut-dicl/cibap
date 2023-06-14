% Instances generator 
% Developed by Dr. Sheraz Aslam
% November 2022
function [DataTable]=Instances_generator(noOfShips,hours, quays)

DataTable.days=hours/24;
%n=10;% number of appliances
minProcessing=3; maxProcessing=7; % min and maximum handing time for ships (min-max values are taken from actual data port of limassol (table presented in J4 ))
LoW1=800; LoW2=750; LoW3=700; LoW4=600; LoW5=750;  % length of different quays
LoW=[LoW1 LoW2 LoW3 LoW4 LoW5];
DataTable.LoW=LoW(1:quays);
xx=hours/8;
[DataTable.PBQ]= pbq_gen(noOfShips, quays);
for i=1:noOfShips % main loop based on number of ships
DataTable.Vessels_(i)=i;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LOS
if rand <0.9; DataTable.vessellength(i)=randi([70,120]); 
else;    DataTable.vessellength(i)=randi([70,200]); end; % we are generating length of all ships in between 84 and 284 meters. (these min and max are taken from original data)
LoV(i)=DataTable.vessellength(i);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DataTable.ProcessingTimeOfVessel(i)=randi([minProcessing,maxProcessing]);
HT(i)=DataTable.ProcessingTimeOfVessel(i);
% for uniform AT generation
x=randi([1,xx]); if x>1; x=(x-1)*8; end

DataTable.ArrivalTimeOfVessel(i)=randi([x,x+8-HT(i)]);
AT(i)=DataTable.ArrivalTimeOfVessel(i);
if length(AT)>1
[AT_n]=AT_check(AT, AT(i));
DataTable.ArrivalTimeOfVessel(i)=AT_n;
AT(i)=AT_n;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DataTable.RequestedDep_Time(i)=randi([AT(i)+HT(i), AT(i)+HT(i)+4]);
DT(i)=DataTable.RequestedDep_Time(i); if DT(i)> hours; DataTable.RequestedDep_Time(i)=hours; end %also checking if dep time is greater than 24. then please make it to 24

%%%%%%%%%%%%%%%%%%%%% PBP

end

[DataTable.LowestCostBerthingPos_]=pbp_gen(DataTable,noOfShips, quays,LoW,LoV);
DataTable;







%pbq generation
function pbq=pbq_gen(noOfShips, quays)
rand_vessels=randperm(noOfShips);
n=round(noOfShips/quays);
pbq=zeros(1,noOfShips);
pbq(rand_vessels(1:n))=1;
    if quays==2
        pbq(rand_vessels(n+1:end))=2;
    elseif quays==3
        pbq(rand_vessels(n+1:n*2))=2;
        pbq(rand_vessels((n*2)+1:end))=3;
    elseif quays==4
        pbq(rand_vessels(n+1:n*2))=2;
        pbq(rand_vessels((n*2)+1:n*3))=3;
        pbq(rand_vessels((n*3)+1:end))=4;
    elseif quays==5
        pbq(rand_vessels(n+1:n*2))=2;
        pbq(rand_vessels((n*2)+1:n*3))=3;
        pbq(rand_vessels((n*3)+1:n*4))=4;
        pbq(rand_vessels((n*4)+1:end))=5;
    end


    %%%%% PBP function
    function pbp=pbp_gen(DataTable,noOfShips, quays,LoW,LoV)
    vessels_q1=find(DataTable.PBQ==1);
    vessels_q2=find(DataTable.PBQ==2);
    vessels_q3=find(DataTable.PBQ==3);
    vessels_q4=find(DataTable.PBQ==4);
    vessels_q5=find(DataTable.PBQ==5);
    DataTable.LowestCostBerthingPos_=DataTable.PBQ;
    %if quays==1
        for i=1:length(find(DataTable.PBQ==1))
            if rem(i,2)==0 && rem(i,4)~=0 && rem(i,3)~=0 %&& rem(i,5)~=0
                DataTable.LowestCostBerthingPos_(vessels_q1(i))=randi([1, round(LoW(1)/3)-LoV(vessels_q1(i))]); % to make diversity in PBP
                    elseif rem(i,3)==0 && rem(i,4)~=0
                    DataTable.LowestCostBerthingPos_(vessels_q1(i))=randi([round(LoW(1)/3+1), round((LoW(1)/3)*2)-LoV(vessels_q1(i))]);
                    %elseif rem(i,4)==0 
                    %DataTable.LowestCostBerthingPos_(i)=randi([round((LoW1/4)*2)+1, round((LoW1/4)*3)-LoV(i)]);
                    else
                    DataTable.LowestCostBerthingPos_(vessels_q1(i))=randi([round((LoW(1)/3)*2), LoW(1)-LoV(vessels_q1(i))]);
            end
        end

%if quays==2
    if quays==2 || quays==3 || quays==4 || quays==5
        for i=1:length(find(DataTable.PBQ==2))
            if rem(i,2)==0 && rem(i,4)~=0 && rem(i,3)~=0 %&& rem(i,5)~=0
                DataTable.LowestCostBerthingPos_(vessels_q2(i))=randi([1, round(LoW(2)/3)-LoV(vessels_q2(i))]); % to make diversity in PBP
                DataTable.LowestCostBerthingPos_(vessels_q2(i))=DataTable.LowestCostBerthingPos_(vessels_q2(i))+sum(LoW(1:1));
                    elseif rem(i,3)==0 && rem(i,4)~=0
                    DataTable.LowestCostBerthingPos_(vessels_q2(i))=randi([round(LoW(2)/3+1), round((LoW(2)/3)*2)-LoV(vessels_q2(i))]);
                    DataTable.LowestCostBerthingPos_(vessels_q2(i))=DataTable.LowestCostBerthingPos_(vessels_q2(i))+sum(LoW(1:1));
                    %elseif rem(i,4)==0 
                    %DataTable.LowestCostBerthingPos_(i)=randi([round((LoW1/4)*2)+1, round((LoW1/4)*3)-LoV(i)]);
                    else
                    DataTable.LowestCostBerthingPos_(vessels_q2(i))=randi([round((LoW(2)/3)*2), LoW(2)-LoV(vessels_q2(i))]);
                    DataTable.LowestCostBerthingPos_(vessels_q2(i))=DataTable.LowestCostBerthingPos_(vessels_q2(i))+sum(LoW(1:1));
            end
        end
    end

%if quays==3
    if quays==3 || quays==4 || quays==5
        for i=1:length(find(DataTable.PBQ==3))
            if rem(i,2)==0 && rem(i,4)~=0 && rem(i,3)~=0 %&& rem(i,5)~=0
                DataTable.LowestCostBerthingPos_(vessels_q3(i))=randi([1, round(LoW(3)/3)-LoV(vessels_q3(i))]); % to make diversity in PBP
                DataTable.LowestCostBerthingPos_(vessels_q3(i))=DataTable.LowestCostBerthingPos_(vessels_q3(i))+sum(LoW(1:2));
                    elseif rem(i,3)==0 && rem(i,4)~=0
                    DataTable.LowestCostBerthingPos_(vessels_q3(i))=randi([round(LoW(3)/3+1), round((LoW(3)/3)*2)-LoV(vessels_q3(i))]);
                    DataTable.LowestCostBerthingPos_(vessels_q3(i))=DataTable.LowestCostBerthingPos_(vessels_q3(i))+sum(LoW(1:2));
                    %elseif rem(i,4)==0 
                    %DataTable.LowestCostBerthingPos_(i)=randi([round((LoW1/4)*2)+1, round((LoW1/4)*3)-LoV(i)]);
                    else
                    DataTable.LowestCostBerthingPos_(vessels_q3(i))=randi([round((LoW(3)/3)*2), LoW(3)-LoV(vessels_q3(i))]);
                    DataTable.LowestCostBerthingPos_(vessels_q3(i))=DataTable.LowestCostBerthingPos_(vessels_q3(i))+sum(LoW(1:2)); % the purpose of extra line is to to add PBP + length of previous quays. e.g., if its 400m on 3rd quay, the length of quay 1+ length quay 2+ 400 is the PBP
            end
        end
    end

%if quays==4
     if quays==4 || quays==5
        for i=1:length(find(DataTable.PBQ==4))
            if rem(i,2)==0 && rem(i,4)~=0 && rem(i,3)~=0 %&& rem(i,5)~=0
                DataTable.LowestCostBerthingPos_(vessels_q4(i))=randi([1, round(LoW(4)/3)-LoV(vessels_q4(i))]); % to make diversity in PBP
                DataTable.LowestCostBerthingPos_(vessels_q4(i))=DataTable.LowestCostBerthingPos_(vessels_q4(i))+sum(LoW(1:3));
                    elseif rem(i,3)==0 && rem(i,4)~=0
                    DataTable.LowestCostBerthingPos_(vessels_q4(i))=randi([round(LoW(4)/3+1), round((LoW(4)/3)*2)-LoV(vessels_q4(i))]);
                    DataTable.LowestCostBerthingPos_(vessels_q4(i))=DataTable.LowestCostBerthingPos_(vessels_q4(i))+sum(LoW(1:3));
                    %elseif rem(i,4)==0 
                    %DataTable.LowestCostBerthingPos_(i)=randi([round((LoW1/4)*2)+1, round((LoW1/4)*3)-LoV(i)]);
                    else
                    DataTable.LowestCostBerthingPos_(vessels_q4(i))=randi([round((LoW(4)/3)*2), LoW(4)-LoV(vessels_q4(i))]);
                    DataTable.LowestCostBerthingPos_(vessels_q4(i))=DataTable.LowestCostBerthingPos_(vessels_q4(i))+sum(LoW(1:3));
            end
        end
     end

%if quays==5
     if quays==5
        for i=1:length(find(DataTable.PBQ==5))
            if rem(i,2)==0 && rem(i,4)~=0 && rem(i,3)~=0 %&& rem(i,5)~=0
                DataTable.LowestCostBerthingPos_(vessels_q5(i))=randi([1, round(LoW(5)/3)-LoV(vessels_q5(i))]); % to make diversity in PBP
                DataTable.LowestCostBerthingPos_(vessels_q5(i))=DataTable.LowestCostBerthingPos_(vessels_q5(i))+sum(LoW(1:4));
                    elseif rem(i,3)==0 && rem(i,4)~=0
                    DataTable.LowestCostBerthingPos_(vessels_q5(i))=randi([round(LoW(5)/3+1), round((LoW(5)/3)*2)-LoV(vessels_q5(i))]);
                    DataTable.LowestCostBerthingPos_(vessels_q5(i))=DataTable.LowestCostBerthingPos_(vessels_q5(i))+sum(LoW(1:4));
                    %elseif rem(i,4)==0 
                    %DataTable.LowestCostBerthingPos_(i)=randi([round((LoW1/4)*2)+1, round((LoW1/4)*3)-LoV(i)]);
                    else
                    DataTable.LowestCostBerthingPos_(vessels_q5(i))=randi([round((LoW(5)/3)*2), LoW(5)-LoV(vessels_q5(i))]);
                    DataTable.LowestCostBerthingPos_(vessels_q5(i))=DataTable.LowestCostBerthingPos_(vessels_q5(i))+sum(LoW(1:4));
            end
        end
     end
     pbp=DataTable.LowestCostBerthingPos_;

     % This function helps in avoiding same at for bht sari kashtian
function AT_last=AT_check(AT, AT_last)
for k=1:length(AT)-1
    if AT_last==AT(k)
        AT_last=AT_last+1;
    else
        AT_last=AT_last;
    end
end