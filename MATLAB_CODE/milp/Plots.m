function [x1]=Plots(BT_CSA, BP_CSA, BT_GA, BP_GA, Quay, LoW, Cost_GA, Cost_CSA, Time_CSA, Time_GA, BT_MILP, BP_MILP,Time_MILP)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           CSA AREA                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BT1_final_CSA=BT_CSA(1:length(Quay.AT1));
BT2_final_CSA=BT_CSA(length(Quay.AT1)+1:length(Quay.AT1)+length(Quay.AT2));
BT3_final_CSA=BT_CSA(length(Quay.AT1)+length(Quay.AT2)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3));
BT4_final_CSA=BT_CSA(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4));
BT5_final_CSA=BT_CSA(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+length(Quay.AT5));

BP1_final_CSA=BP_CSA(1:length(Quay.AT1));
BP2_final_CSA=BP_CSA(length(Quay.AT1)+1:length(Quay.AT1)+length(Quay.AT2));
BP3_final_CSA=BP_CSA(length(Quay.AT1)+length(Quay.AT2)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3));
BP4_final_CSA=BP_CSA(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4));
BP5_final_CSA=BP_CSA(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+length(Quay.AT5));

Quay.LoS1=Quay.LoS1-10; Quay.LoS2=Quay.LoS2-10; Quay.LoS3=Quay.LoS3-10; Quay.LoS4=Quay.LoS4-10; Quay.LoS5=Quay.LoS5-10; %10 meters is saftey distance and it was added before and now excluded
Quay.pTime1=Quay.pTime1-1; Quay.pTime2=Quay.pTime2-1; Quay.pTime3=Quay.pTime3-1; Quay.pTime4=Quay.pTime4-1; Quay.pTime5=Quay.pTime5-1;



%Plot1                  % places of ships (Solution by CSA)   Q1
for i=1:length(BT1_final_CSA)
x1=BT1_final_CSA(i);
x2=BT1_final_CSA(i)+Quay.pTime1(i);
y1=BP1_final_CSA(i)+Quay.LoS1(i);
y2=BP1_final_CSA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
%q1
txt=[int2str(Quay.SS1(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 450]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 450m');
title ('Berth allocation by CSA (Container/ Ro-Ro Quay)');
box on;
grid on;
end
hold off;


% 
%Plot2                  % places of ships (Solution by CSA) Q2
figure
for i=1:length(BT2_final_CSA)
x1=BT2_final_CSA(i);
x2=BT2_final_CSA(i)+Quay.pTime2(i);
y1=BP2_final_CSA(i)+Quay.LoS2(i);
y2=BP2_final_CSA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS2(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 800]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 800m');
title ('Berth allocation by CSA (Container Quay)');
box on;
grid on;
end
hold off;



% 
%Plot3                  % places of ships (Solution by CSA) Q3
figure
for i=1:length(BT3_final_CSA)
x1=BT3_final_CSA(i);
x2=BT3_final_CSA(i)+Quay.pTime3(i);
y1=BP3_final_CSA(i)+Quay.LoS3(i);
y2=BP3_final_CSA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS3(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 480]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 480m');
title ('Berth allocation by CSA (East Quay)');
box on;
grid on;
end
hold off;


% 
%Plot4                  % places of ships (Solution by CSA) Q4
figure
for i=1:length(BT4_final_CSA)
x1=BT4_final_CSA(i);
x2=BT4_final_CSA(i)+Quay.pTime4(i);
y1=BP4_final_CSA(i)+Quay.LoS4(i);
y2=BP4_final_CSA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS4(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 770]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 770m');
title ('Berth allocation by CSA (West Quay)');
box on;
grid on;
end
hold off;


% 
%Plot5                  % places of ships (Solution by CSA) Q5
figure
for i=1:length(BT5_final_CSA)
x1=BT5_final_CSA(i);
x2=BT5_final_CSA(i)+Quay.pTime5(i);
y1=BP5_final_CSA(i)+Quay.LoS5(i);
y2=BP5_final_CSA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS5(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 430]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 430m');
title ('Berth allocation by CSA (North Quay)');
box on;
grid on;
end
hold on;





%                           ONE WEEK Horizon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           GA AREA                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BT1_final_GA=BT_GA(1:length(Quay.AT1));
BT2_final_GA=BT_GA(length(Quay.AT1)+1:length(Quay.AT1)+length(Quay.AT2));
BT3_final_GA=BT_GA(length(Quay.AT1)+length(Quay.AT2)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3));
BT4_final_GA=BT_GA(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4));
BT5_final_GA=BT_GA(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+length(Quay.AT5));

BP1_final_GA=BP_GA(1:length(Quay.AT1));
BP2_final_GA=BP_GA(length(Quay.AT1)+1:length(Quay.AT1)+length(Quay.AT2));
BP3_final_GA=BP_GA(length(Quay.AT1)+length(Quay.AT2)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3));
BP4_final_GA=BP_GA(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4));
BP5_final_GA=BP_GA(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+length(Quay.AT5));


%Plot1                  % places of ships (Solution by GA)  Q1
figure
for i=1:length(BT1_final_GA)
x1=BT1_final_GA(i);
x2=BT1_final_GA(i)+Quay.pTime1(i);
y1=BP1_final_GA(i)+Quay.LoS1(i);
y2=BP1_final_GA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS1(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 450]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 450m');
title ('Berth allocation by GA (Container/ Ro-Ro Quay)');
box on;
grid on;
end
hold off;


% 
%Plot2                  % places of ships (Solution by GA) Q2
figure
for i=1:length(BT2_final_GA)
x1=BT2_final_GA(i);
x2=BT2_final_GA(i)+Quay.pTime2(i);
y1=BP2_final_GA(i)+Quay.LoS2(i);
y2=BP2_final_GA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS2(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 800]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 800m');
title ('Berth allocation by GA (Container Quay)');
box on;
grid on;
end
hold off;


% 
%Plot3                  % places of ships (Solution by GA) Q3
figure
for i=1:length(BT3_final_GA)
x1=BT3_final_GA(i);
x2=BT3_final_GA(i)+Quay.pTime3(i);
y1=BP3_final_GA(i)+Quay.LoS3(i);
y2=BP3_final_GA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS3(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 480]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 480m');
title ('Berth allocation by GA (East Quay)');
box on;
grid on;
% Set the remaining axes properties
%set(gca,'XTick',[0 2 4 6 8 10 12 14 16 18 20 22 24],'XTickLabel',...
%    {'0','2','4','6','8','10','12','14','16','18','20', '22', '24'});
end
hold off;


% 
%Plot4                  % places of ships (Solution by GA) Q4
figure
for i=1:length(BT4_final_GA)
x1=BT4_final_GA(i);
x2=BT4_final_GA(i)+Quay.pTime4(i);
y1=BP4_final_GA(i)+Quay.LoS4(i);
y2=BP4_final_GA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS4(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 770]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 770m');
title ('Berth allocation by GA (West Quay)');
box on;
grid on;
% Set the remaining axes properties
%set(gca,'XTick',[0 2 4 6 8 10 12 14 16 18 20 22 24],'XTickLabel',...
%    {'0','2','4','6','8','10','12','14','16','18','20', '22', '24'});
end
hold off;


% 
%Plot5                  % places of ships (Solution by GA) Q5
figure
for i=1:length(BT5_final_GA)
x1=BT5_final_GA(i);
x2=BT5_final_GA(i)+Quay.pTime5(i);
y1=BP5_final_GA(i)+Quay.LoS5(i);
y2=BP5_final_GA(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS5(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 430]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 430m');
title ('Berth allocation by GA (North Quay)');
box on;
grid on;
% Set the remaining axes properties
%set(gca,'XTick',[0 2 4 6 8 10 12 14 16 18 20 22 24],'XTickLabel',...
%    {'0','2','4','6','8','10','12','14','16','18','20', '22', '24'});
end
hold off;



%%%%%               ONE WEEK PLANNING HORIZON        %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MILP AREA                                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BT1_final_MILP=BT_MILP(1:length(Quay.AT1));
BT2_final_MILP=BT_MILP(length(Quay.AT1)+1:length(Quay.AT1)+length(Quay.AT2));
BT3_final_MILP=BT_MILP(length(Quay.AT1)+length(Quay.AT2)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3));
BT4_final_MILP=BT_MILP(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4));
BT5_final_MILP=BT_MILP(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+length(Quay.AT5));

BP1_final_MILP=BP_MILP(1:length(Quay.AT1));
BP2_final_MILP=BP_MILP(length(Quay.AT1)+1:length(Quay.AT1)+length(Quay.AT2));
BP3_final_MILP=BP_MILP(length(Quay.AT1)+length(Quay.AT2)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3));
BP4_final_MILP=BP_MILP(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4));
BP5_final_MILP=BP_MILP(length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+1:length(Quay.AT1)+length(Quay.AT2)+length(Quay.AT3)+length(Quay.AT4)+length(Quay.AT5));




%Plot1                  % places of ships (Solution by CSA)   Q1
figure
for i=1:length(BT1_final_MILP)
x1=BT1_final_MILP(i);
x2=BT1_final_MILP(i)+Quay.pTime1(i);
y1=BP1_final_MILP(i)+Quay.LoS1(i);
y2=BP1_final_MILP(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS1(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 450]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 450m');
title ('Berth allocation by MILP (Container/ Ro-Ro Quay)');
box on;
grid on;
% Set the remaining axes properties
%set(gca,'XTick',[0 2 4 6 8 10 12 14 16 18 20 22 24],'XTickLabel',...
%    {'0','2','4','6','8','10','12','14','16','18','20', '22', '24'});
end
hold off;


% 
%Plot2                  % places of ships (Solution by CSA) Q2
figure
for i=1:length(BT2_final_MILP)
x1=BT2_final_MILP(i);
x2=BT2_final_MILP(i)+Quay.pTime2(i);
y1=BP2_final_MILP(i)+Quay.LoS2(i);
y2=BP2_final_MILP(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS2(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 800]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 800m');
title ('Berth allocation by MILP (Container Quay)');
box on;
grid on;
% Set the remaining axes properties
%set(gca,'XTick',[0 2 4 6 8 10 12 14 16 18 20 22 24],'XTickLabel',...
%    {'0','2','4','6','8','10','12','14','16','18','20', '22', '24'});
end
hold off;




% 
%Plot3                  % places of ships (Solution by CSA) Q3
figure
for i=1:length(BT3_final_MILP)
x1=BT3_final_MILP(i);
x2=BT3_final_MILP(i)+Quay.pTime3(i);
y1=BP3_final_MILP(i)+Quay.LoS3(i);
y2=BP3_final_MILP(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS3(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 480]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 480m');
title ('Berth allocation by MILP (East Quay)');
box on;
grid on;
% Set the remaining axes properties
%set(gca,'XTick',[0 2 4 6 8 10 12 14 16 18 20 22 24],'XTickLabel',...
%    {'0','2','4','6','8','10','12','14','16','18','20', '22', '24'});
end
hold off;


% 
%Plot4                  % places of ships (Solution by CSA) Q4
figure
for i=1:length(BT4_final_MILP)
x1=BT4_final_MILP(i);
x2=BT4_final_MILP(i)+Quay.pTime4(i);
y1=BP4_final_MILP(i)+Quay.LoS4(i);
y2=BP4_final_MILP(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS4(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 770]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 770m');
title ('Berth allocation by MILP (West Quay)');
box on;
grid on;
% Set the remaining axes properties
%set(gca,'XTick',[0 2 4 6 8 10 12 14 16 18 20 22 24],'XTickLabel',...
%    {'0','2','4','6','8','10','12','14','16','18','20', '22', '24'});
end
hold off;


% 
%Plot5                  % places of ships (Solution by CSA) Q5
figure
for i=1:length(BT5_final_MILP)
x1=BT5_final_MILP(i);
x2=BT5_final_MILP(i)+Quay.pTime5(i);
y1=BP5_final_MILP(i)+Quay.LoS5(i);
y2=BP5_final_MILP(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'r-', 'LineWidth', 1);
txt=[int2str(Quay.SS5(i))];
text((x1+x2)/2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
ylim([0, 430]);
xlabel('Time (30-min interval)');
ylabel('Wharf length = 430m');
title ('Berth allocation by MILP (North Quay)');
box on;
grid on;
% Set the remaining axes properties
%set(gca,'XTick',[0 2 4 6 8 10 12 14 16 18 20 22 24],'XTickLabel',...
%    {'0','2','4','6','8','10','12','14','16','18','20', '22', '24'});
end
hold on;


















AT=[Quay.AT1 Quay.AT2 Quay.AT3 Quay.AT4 Quay.AT5];
pTime=[Quay.pTime1 Quay.pTime2 Quay.pTime3 Quay.pTime4 Quay.pTime5];
departure=[Quay.dep1 Quay.dep2 Quay.dep3 Quay.dep4 Quay.dep5];
% % calculations for plots CSA
 for a=1:length(AT)
waitingTime_CSA(a)=BT_CSA(a)-AT(a);
if waitingTime_CSA(a)<0
    waitingTime_CSA(a)=0;
 end
 end
% 
% % calculations for plots GA
 for a=1:length(AT)
 waitingTime_GA(a)=BT_GA(a)-AT(a);
 if waitingTime_GA(a)<0
     waitingTime_GA(a)=0;
 end
 end
 

 % Waiting time for MILP
 for a=1:length(AT)
 waitingTime_MILP(a)=BT_MILP(a)-AT(a); % waiting time by mILP
 handling_cost_MILP(a)=pTime(a)*5; % handling cost
 LateDeparture_MILP(a)=BTfinal_MILP(a)-departure(a);
 if waitingTime_MILP(a)<0
     waitingTime_MILP(a)=0;
 end
 end
 waiting_cost_MILP=waitingTime_MILP*10;
 LateDepartureCost_MILP=LateDeparture_MILP*20;
  


%           Total COST of all 4 algos
Total_cost_GA=Cost_GA;
Total_cost_CSA=Cost_CSA;
%Total_cost_PSO=Cost_PSO;
% Total_cost_MILP=sum(waiting_cost_MILP)+sum(handling_cost_MILP)+sum(LateDepartureCost_MILP);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                   Plots
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% %plot3                  Requested and CSA, GA, and MILP departure time
departure2=BT_CSA+pTime;
departure3=BT_GA+pTime;
%departure4=BT_PSO+pTime;
departure5=BT_MILP+pTime;
 figure
bpcombined = [departure2(:), departure3(:), departure5(:), departure(:)]; 
 hb = bar(bpcombined, 'grouped');
 legend('Solution by CSA','Solution by GA', 'Solution by MILP', 'Requested departure time', 'Location','northwest');
 xlabel('Ships');
 ylabel('Time (30-min interval)');
% ylim([0, 24]);
%box(axes1,'on');
% % Set the remaining axes properties
% set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10],'XTickLabel',...
%     {'10','20','30','40','50','60','70','80','90','100'});
% % Create legend
% %legend1 = legend(axes1,'show');
hold on
%





% %plot4                  Waiting time
 figure
 bpcombined = [waitingTime_CSA(:), waitingTime_GA(:), waitingTime_MILP(:)]; 
 hb = bar(bpcombined, 'grouped');
 hold on
 xlabel('Ships');
 ylabel('Time (30-min interval)');
 legend('Waiting time by CSA','Waiting time by GA', 'Waiting time by MILP', 'Location','northwest');
% %xlim([0 10]);
% 
% 
% %plot5 % handling time and waiting time 
% figure
% for aa=1:length(AT)
% yy(aa,:)= [waitingTime_CSA(aa) pTime(aa)];
% end
% bar(yy,'stacked')
% legend('Waiting time by CSA','Actual processing time');
% xlabel('Ships');
% ylabel('Time (30-min interval)');
% hold on
% 
% 
% %plot5(b) % handling time and waiting time 
% figure
% for aa=1:length(AT)
% yy(aa,:)= [waitingTime_GA(aa) pTime(aa)];
% end
% bar(yy,'stacked')
% legend('Waiting time by GA','Actual processing time');
% xlabel('Ships');
% ylabel('Time (30-min interval)');
% hold on
% 
% %                       Convergance plot
% 
% figure
% plot(bestSofar,'r','markersize',8,'LineWidth',1.5)
% hold on
% plot(Convergance_CSA,'b','markersize',8,'LineWidth',1.5)
% hold on
% xlabel('Iterations');
% ylabel('Fitness value');
% legend('GA','CSA','Location','southeast');%,'Location','northeast'
% grid on
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TOTAL COST   %%%%%%%%%%%%%%
 figure		
 bar(1,Total_cost_CSA,0.3)		
 hold on		
 bar(2,Total_cost_GA,0.3)		
 hold on
 bar(3,Total_cost_CSA,0.3)		
 hold on		
 set(gca, 'XTick',1:1:3, 'XTickLabel',{'CSA cost', 'GA cost', 'MILP Cost'})		
 ylabel('Total cost (euro)');				
 grid on
% 
% 
% %       Execution time plot
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TOTAL COST   %%%%%%%%%%%%%%
% figure		
% bar(1,Time_GA,0.3,'red')		
% hold on		
% bar(2,Time_CSA,0.3,'green')		
% hold on
% bar(3,Time_MILP,0.3,'yellow')		
% hold on
% set(gca, 'XTick',1:1:3, 'XTickLabel',{'GA time', 'CSA time', 'MILP time'})		
% ylabel('Total execution time (Seconds)');				
% grid on
% 
% %       print execution time
fprintf('The execution time of CSA is : %d Seconds.\n', Time_CSA); 
fprintf('The execution time of GA is : %d Seconds.\n', Time_GA);
%fprintf('The execution time of CSA is : %d Seconds.\n', Time_PSO);
fprintf('The execution time of MILP is : %d Seconds.\n', Time_MILP);
% 
% % print total cost
% fprintf('The total cost using GA is : %d Euros.\n', Total_cost_GA);
% fprintf('The total cost using CSA is : %d Euros.\n', Total_cost_CSA);
% fprintf('The total cost using MILP is is : %d Euros.\n', Total_cost_MILP);
