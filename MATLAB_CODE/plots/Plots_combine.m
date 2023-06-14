function [x2]=Plots_combine(BT_CSA, BP_CSA, BQ_CSA, BT_GA, BP_GA, BQ_GA, BT_PSO, BP_PSO, BQ_PSO, BT_MILP, BP_MILP, BQ_MILP, LoW, Time_CSA, Time_GA, Time_PSO, Time_MILP, data, Total_cost_CSA, Total_cost_GA, Total_cost_PSO, Total_cost_MILP, waitingTime_CSA, waitingTime_GA, waitingTime_PSO, waitingTime_MILP, NOB_cost_MILP, NOB_cost_PSO, NOB_cost_GA, NOB_cost_CSA)


%Quay.LoS1=Quay.LoS1-10; Quay.LoS2=Quay.LoS2-10; Quay.LoS3=Quay.LoS3-10; Quay.LoS4=Quay.LoS4-10; Quay.LoS5=Quay.LoS5-10; %10 meters is saftey distance and it was added before and now excluded
%Quay.pTime1=Quay.pTime1-1; Quay.pTime2=Quay.pTime2-1; Quay.pTime3=Quay.pTime3-1; Quay.pTime4=Quay.pTime4-1; Quay.pTime5=Quay.pTime5-1; % 1 time slot is safety time
data.LoS=data.LoS-10;
data.pTime=data.pTime-1;

%                       CSA area
for i=1:length(data.AT)
    if BQ_CSA(i)==1
        BT1_final_CSA(i)=BT_CSA(i);    BP1_final_CSA(i)=BP_CSA(i);
        elseif BQ_CSA(i)==2
        BT2_final_CSA(i)=BT_CSA(i);    BP2_final_CSA(i)=BP_CSA(i)-sum(LoW(1:2-1));
        elseif BQ_CSA(i)==3
        BT3_final_CSA(i)=BT_CSA(i);    BP3_final_CSA(i)=BP_CSA(i)-sum(LoW(1:3-1));
        elseif BQ_CSA(i)==4
        BT4_final_CSA(i)=BT_CSA(i);    BP4_final_CSA(i)=BP_CSA(i)-sum(LoW(1:4-1));
        elseif BQ_CSA(i)==5
        BT5_final_CSA(i)=BT_CSA(i);    BP5_final_CSA(i)=BP_CSA(i)-sum(LoW(1:5-1));
    end
end
%BT
results.CSA_BT1=BT1_final_CSA(BT1_final_CSA~=0); results.CSA_BT2=BT2_final_CSA(BT2_final_CSA~=0); results.CSA_BT3=BT3_final_CSA(BT3_final_CSA~=0); results.CSA_BT4=BT4_final_CSA(BT4_final_CSA~=0); results.CSA_BT5=BT5_final_CSA(BT5_final_CSA~=0);
%BP
results.CSA_BP1=BP1_final_CSA(BP1_final_CSA~=0); results.CSA_BP2=BP2_final_CSA(BP2_final_CSA~=0); results.CSA_BP3=BP3_final_CSA(BP3_final_CSA~=0); results.CSA_BP4=BP4_final_CSA(BP4_final_CSA~=0); results.CSA_BP5=BP5_final_CSA(BP5_final_CSA~=0);
% ship number
results.CSA_shipAtQ1=find(BT1_final_CSA); results.CSA_shipAtQ2=find(BT2_final_CSA); results.CSA_shipAtQ3=find(BT3_final_CSA); results.CSA_shipAtQ4=find(BT4_final_CSA); results.CSA_shipAtQ5=find(BT5_final_CSA);




%                       GA area
for i=1:length(data.AT)
    if BQ_GA(i)==1
        BT1_final_GA(i)=BT_GA(i);    BP1_final_GA(i)=BP_GA(i);
        elseif BQ_GA(i)==2
        BT2_final_GA(i)=BT_GA(i);    BP2_final_GA(i)=BP_GA(i)-sum(LoW(1:2-1));
        elseif BQ_GA(i)==3
        BT3_final_GA(i)=BT_GA(i);    BP3_final_GA(i)=BP_GA(i)-sum(LoW(1:3-1));
        elseif BQ_GA(i)==4
        BT4_final_GA(i)=BT_GA(i);    BP4_final_GA(i)=BP_GA(i)-sum(LoW(1:4-1));
        elseif BQ_GA(i)==5
        BT5_final_GA(i)=BT_GA(i);    BP5_final_GA(i)=BP_GA(i)-sum(LoW(1:5-1));
    end
end
%BT
results.GA_BT1=BT1_final_GA(BT1_final_GA~=0); results.GA_BT2=BT2_final_GA(BT2_final_GA~=0); results.GA_BT3=BT3_final_GA(BT3_final_GA~=0); results.GA_BT4=BT4_final_GA(BT4_final_GA~=0); results.GA_BT5=BT5_final_GA(BT5_final_GA~=0);
%BP
results.GA_BP1=BP1_final_GA(BP1_final_GA~=0); results.GA_BP2=BP2_final_GA(BP2_final_GA~=0); results.GA_BP3=BP3_final_GA(BP3_final_GA~=0); results.GA_BP4=BP4_final_GA(BP4_final_GA~=0); results.GA_BP5=BP5_final_GA(BP5_final_GA~=0);
% ship number
results.GA_shipAtQ1=find(BT1_final_GA); results.GA_shipAtQ2=find(BT2_final_GA); results.GA_shipAtQ3=find(BT3_final_GA); results.GA_shipAtQ4=find(BT4_final_GA); results.GA_shipAtQ5=find(BT5_final_GA);


%                       PSO area
for i=1:length(data.AT)
    if BQ_PSO(i)==1
        BT1_final_PSO(i)=BT_PSO(i);    BP1_final_PSO(i)=BP_PSO(i);
        elseif BQ_PSO(i)==2
        BT2_final_PSO(i)=BT_PSO(i);    BP2_final_PSO(i)=BP_PSO(i)-sum(LoW(1:2-1));
        elseif BQ_PSO(i)==3
        BT3_final_PSO(i)=BT_PSO(i);    BP3_final_PSO(i)=BP_PSO(i)-sum(LoW(1:3-1));
        elseif BQ_PSO(i)==4
        BT4_final_PSO(i)=BT_PSO(i);    BP4_final_PSO(i)=BP_PSO(i)-sum(LoW(1:4-1));
        elseif BQ_PSO(i)==5
        BT5_final_PSO(i)=BT_PSO(i);    BP5_final_PSO(i)=BP_PSO(i)-sum(LoW(1:5-1));
    end
end
%BT
results.PSO_BT1=BT1_final_PSO(BT1_final_PSO~=0); results.PSO_BT2=BT2_final_PSO(BT2_final_PSO~=0); results.PSO_BT3=BT3_final_PSO(BT3_final_PSO~=0); results.PSO_BT4=BT4_final_PSO(BT4_final_PSO~=0); results.PSO_BT5=BT5_final_PSO(BT5_final_PSO~=0);
%BP
results.PSO_BP1=BP1_final_PSO(BP1_final_PSO~=0); results.PSO_BP2=BP2_final_PSO(BP2_final_PSO~=0); results.PSO_BP3=BP3_final_PSO(BP3_final_PSO~=0); results.PSO_BP4=BP4_final_PSO(BP4_final_PSO~=0); results.PSO_BP5=BP5_final_PSO(BP5_final_PSO~=0);
% ship number
results.PSO_shipAtQ1=find(BT1_final_PSO); results.PSO_shipAtQ2=find(BT2_final_PSO); results.PSO_shipAtQ3=find(BT3_final_PSO); results.PSO_shipAtQ4=find(BT4_final_PSO); results.PSO_shipAtQ5=find(BT5_final_PSO);


%                       MILP area
for i=1:length(data.AT)
    if BQ_MILP(i)==1
        BT1_final_MILP(i)=BT_MILP(i);    BP1_final_MILP(i)=BP_MILP(i);
        elseif BQ_MILP(i)==2
        BT2_final_MILP(i)=BT_MILP(i);    BP2_final_MILP(i)=BP_MILP(i)-sum(LoW(1:2-1));
        elseif BQ_MILP(i)==3
        BT3_final_MILP(i)=BT_MILP(i);    BP3_final_MILP(i)=BP_MILP(i)-sum(LoW(1:3-1));
        elseif BQ_MILP(i)==4
        BT4_final_MILP(i)=BT_MILP(i);    BP4_final_MILP(i)=BP_MILP(i)-sum(LoW(1:4-1));
        elseif BQ_MILP(i)==5
        BT5_final_MILP(i)=BT_MILP(i);    BP5_final_MILP(i)=BP_MILP(i)-sum(LoW(1:5-1));
    end
end
%BT
results.MILP_BT1=BT1_final_MILP(BT1_final_MILP~=0); results.MILP_BT2=BT2_final_MILP(BT2_final_MILP~=0); results.MILP_BT3=BT3_final_MILP(BT3_final_MILP~=0); results.MILP_BT4=BT4_final_MILP(BT4_final_MILP~=0); results.MILP_BT5=BT5_final_MILP(BT5_final_MILP~=0);
%BP
results.MILP_BP1=BP1_final_MILP(BP1_final_MILP~=0); results.MILP_BP2=BP2_final_MILP(BP2_final_MILP~=0); results.MILP_BP3=BP3_final_MILP(BP3_final_MILP~=0); results.MILP_BP4=BP4_final_MILP(BP4_final_MILP~=0); results.MILP_BP5=BP5_final_MILP(BP5_final_MILP~=0);
% ship number
results.MILP_shipAtQ1=find(BT1_final_MILP); results.MILP_shipAtQ2=find(BT2_final_MILP); results.MILP_shipAtQ3=find(BT3_final_MILP); results.MILP_shipAtQ4=find(BT4_final_MILP); results.MILP_shipAtQ5=find(BT5_final_MILP);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      COMBINED plot
figure
subplot(5,1,1)      
for i=1:length(results.CSA_BT1)
x1=results.CSA_BT1(i);
x2=results.CSA_BT1(i)+data.pTime(results.CSA_shipAtQ1(i));
y1=results.CSA_BP1(i)+data.LoS(results.CSA_shipAtQ1(i));
y2=results.CSA_BP1(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_CSA(results.CSA_shipAtQ1(i))==data.PBQ(results.CSA_shipAtQ1(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.CSA_shipAtQ1(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(1)]);
title ('(Container/ Ro-Ro Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;

subplot(5,1,2)       
for i=1:length(results.CSA_BT2)
x1=results.CSA_BT2(i);
x2=results.CSA_BT2(i)+data.pTime(results.CSA_shipAtQ2(i));
y1=results.CSA_BP2(i)+data.LoS(results.CSA_shipAtQ2(i));
y2=results.CSA_BP2(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_CSA(results.CSA_shipAtQ2(i))==data.PBQ(results.CSA_shipAtQ2(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.CSA_shipAtQ2(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(2)]);
title ('(Container Quay)');
box on;
grid on;
end
hold off;

subplot(5,1,3)      
for i=1:length(results.CSA_BT3)
x1=results.CSA_BT3(i);
x2=results.CSA_BT3(i)+data.pTime(results.CSA_shipAtQ3(i));
y1=results.CSA_BP3(i)+data.LoS(results.CSA_shipAtQ3(i));
y2=results.CSA_BP3(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'b-', 'LineWidth', 1);
txt=[int2str(results.CSA_shipAtQ3(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(3)]);
ylabel('Wharf length');
title ('(East Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;

subplot(5,1,4)       
for i=1:length(results.CSA_BT4)
x1=results.CSA_BT4(i);
x2=results.CSA_BT4(i)+data.pTime(results.CSA_shipAtQ4(i));
y1=results.CSA_BP4(i)+data.LoS(results.CSA_shipAtQ4(i));
y2=results.CSA_BP4(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_CSA(results.CSA_shipAtQ4(i))==data.PBQ(results.CSA_shipAtQ4(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.CSA_shipAtQ4(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
set(gca,'XTickLabel',[]);
ylim([0, LoW(4)]);
%xlabel('Time (30-min interval)');
%ylabel('Wharf length = 450m');
title ('(West Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;


subplot(5,1,5)       
for i=1:length(results.CSA_BT5)
x1=results.CSA_BT5(i);
x2=results.CSA_BT5(i)+data.pTime(results.CSA_shipAtQ5(i));
y1=results.CSA_BP5(i)+data.LoS(results.CSA_shipAtQ5(i));
y2=results.CSA_BP5(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_CSA(results.CSA_shipAtQ5(i))==data.PBQ(results.CSA_shipAtQ5(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.CSA_shipAtQ5(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
%set(gca,'XTickLabel',[]);
ylim([0, LoW(5)]);
xlabel('Time (30-min interval)');
%ylabel('Wharf length = 450m');
title ('(North Quay)');
set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
     {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               GA
figure
subplot(5,1,1)      
for i=1:length(results.GA_BT1)
x1=results.GA_BT1(i);
x2=results.GA_BT1(i)+data.pTime(results.GA_shipAtQ1(i));
y1=results.GA_BP1(i)+data.LoS(results.GA_shipAtQ1(i));
y2=results.GA_BP1(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_GA(results.GA_shipAtQ1(i))==data.PBQ(results.GA_shipAtQ1(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.GA_shipAtQ1(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(1)]);
title ('(Container/ Ro-Ro Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;

subplot(5,1,2)       
for i=1:length(results.GA_BT2)
x1=results.GA_BT2(i);
x2=results.GA_BT2(i)+data.pTime(results.GA_shipAtQ2(i));
y1=results.GA_BP2(i)+data.LoS(results.GA_shipAtQ2(i));
y2=results.GA_BP2(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_GA(results.GA_shipAtQ2(i))==data.PBQ(results.GA_shipAtQ2(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.GA_shipAtQ2(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(2)]);
title ('(Container Quay)');
box on;
grid on;
end
hold off;

subplot(5,1,3)      
for i=1:length(results.GA_BT3)
x1=results.GA_BT3(i);
x2=results.GA_BT3(i)+data.pTime(results.GA_shipAtQ3(i));
y1=results.GA_BP3(i)+data.LoS(results.GA_shipAtQ3(i));
y2=results.GA_BP3(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'b-', 'LineWidth', 1);
txt=[int2str(results.GA_shipAtQ3(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(3)]);
ylabel('Wharf length');
title ('(East Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;

subplot(5,1,4)       
for i=1:length(results.GA_BT4)
x1=results.GA_BT4(i);
x2=results.GA_BT4(i)+data.pTime(results.GA_shipAtQ4(i));
y1=results.GA_BP4(i)+data.LoS(results.GA_shipAtQ4(i));
y2=results.GA_BP4(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_GA(results.GA_shipAtQ4(i))==data.PBQ(results.GA_shipAtQ4(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.GA_shipAtQ4(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
set(gca,'XTickLabel',[]);
ylim([0, LoW(4)]);
%xlabel('Time (30-min interval)');
%ylabel('Wharf length = 450m');
title ('(West Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;


subplot(5,1,5)       
for i=1:length(results.GA_BT5)
x1=results.GA_BT5(i);
x2=results.GA_BT5(i)+data.pTime(results.GA_shipAtQ5(i));
y1=results.GA_BP5(i)+data.LoS(results.GA_shipAtQ5(i));
y2=results.GA_BP5(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_GA(results.GA_shipAtQ5(i))==data.PBQ(results.GA_shipAtQ5(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.GA_shipAtQ5(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
%set(gca,'XTickLabel',[]);
ylim([0, LoW(5)]);
xlabel('Time (30-min interval)');
%ylabel('Wharf length = 450m');
title ('(North Quay)');
set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
     {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               PSO
figure
subplot(5,1,1)      
for i=1:length(results.PSO_BT1)
x1=results.PSO_BT1(i);
x2=results.PSO_BT1(i)+data.pTime(results.PSO_shipAtQ1(i));
y1=results.PSO_BP1(i)+data.LoS(results.PSO_shipAtQ1(i));
y2=results.PSO_BP1(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_PSO(results.PSO_shipAtQ1(i))==data.PBQ(results.PSO_shipAtQ1(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.PSO_shipAtQ1(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(1)]);
title ('(Container/ Ro-Ro Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;

subplot(5,1,2)       
for i=1:length(results.PSO_BT2)
x1=results.PSO_BT2(i);
x2=results.PSO_BT2(i)+data.pTime(results.PSO_shipAtQ2(i));
y1=results.PSO_BP2(i)+data.LoS(results.PSO_shipAtQ2(i));
y2=results.PSO_BP2(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_PSO(results.PSO_shipAtQ2(i))==data.PBQ(results.PSO_shipAtQ2(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.PSO_shipAtQ2(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(2)]);
title ('(Container Quay)');
box on;
grid on;
end
hold off;

subplot(5,1,3)      
for i=1:length(results.PSO_BT3)
x1=results.PSO_BT3(i);
x2=results.PSO_BT3(i)+data.pTime(results.PSO_shipAtQ3(i));
y1=results.PSO_BP3(i)+data.LoS(results.PSO_shipAtQ3(i));
y2=results.PSO_BP3(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'b-', 'LineWidth', 1);
txt=[int2str(results.PSO_shipAtQ3(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(3)]);
ylabel('Wharf length');
title ('(East Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;

subplot(5,1,4)       
for i=1:length(results.PSO_BT4)
x1=results.PSO_BT4(i);
x2=results.PSO_BT4(i)+data.pTime(results.PSO_shipAtQ4(i));
y1=results.PSO_BP4(i)+data.LoS(results.PSO_shipAtQ4(i));
y2=results.PSO_BP4(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_PSO(results.PSO_shipAtQ4(i))==data.PBQ(results.PSO_shipAtQ4(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.PSO_shipAtQ4(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
set(gca,'XTickLabel',[]);
ylim([0, LoW(4)]);
%xlabel('Time (30-min interval)');
%ylabel('Wharf length = 450m');
title ('(West Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;


subplot(5,1,5)       
for i=1:length(results.PSO_BT5)
x1=results.PSO_BT5(i);
x2=results.PSO_BT5(i)+data.pTime(results.PSO_shipAtQ5(i));
y1=results.PSO_BP5(i)+data.LoS(results.PSO_shipAtQ5(i));
y2=results.PSO_BP5(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_PSO(results.PSO_shipAtQ5(i))==data.PBQ(results.PSO_shipAtQ5(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.PSO_shipAtQ5(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
%set(gca,'XTickLabel',[]);
ylim([0, LoW(5)]);
xlabel('Time (30-min interval)');
%ylabel('Wharf length = 450m');
title ('(North Quay)');
set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
     {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               MILP
figure
subplot(5,1,1)      
for i=1:length(results.MILP_BT1)
x1=results.MILP_BT1(i);
x2=results.MILP_BT1(i)+data.pTime(results.MILP_shipAtQ1(i));
y1=results.MILP_BP1(i)+data.LoS(results.MILP_shipAtQ1(i));
y2=results.MILP_BP1(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_MILP(results.MILP_shipAtQ1(i))==data.PBQ(results.MILP_shipAtQ1(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.MILP_shipAtQ1(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(1)]);
title ('(Container/ Ro-Ro Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;

subplot(5,1,2)       
for i=1:length(results.MILP_BT2)
x1=results.MILP_BT2(i);
x2=results.MILP_BT2(i)+data.pTime(results.MILP_shipAtQ2(i));
y1=results.MILP_BP2(i)+data.LoS(results.MILP_shipAtQ2(i));
y2=results.MILP_BP2(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_MILP(results.MILP_shipAtQ2(i))==data.PBQ(results.MILP_shipAtQ2(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.MILP_shipAtQ2(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(2)]);
title ('(Container Quay)');
box on;
grid on;
end
hold off;

subplot(5,1,3)      
for i=1:length(results.MILP_BT3)
x1=results.MILP_BT3(i);
x2=results.MILP_BT3(i)+data.pTime(results.MILP_shipAtQ3(i));
y1=results.MILP_BP3(i)+data.LoS(results.MILP_shipAtQ3(i));
y2=results.MILP_BP3(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
plot(x, y, 'b-', 'LineWidth', 1);
txt=[int2str(results.MILP_shipAtQ3(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
set(gca,'XTickLabel',[]);
xlim([0, 336]);
ylim([0, LoW(3)]);
ylabel('Wharf length');
title ('(East Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;

subplot(5,1,4)       
for i=1:length(results.MILP_BT4)
x1=results.MILP_BT4(i);
x2=results.MILP_BT4(i)+data.pTime(results.MILP_shipAtQ4(i));
y1=results.MILP_BP4(i)+data.LoS(results.MILP_shipAtQ4(i));
y2=results.MILP_BP4(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_MILP(results.MILP_shipAtQ4(i))==data.PBQ(results.MILP_shipAtQ4(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.MILP_shipAtQ4(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
set(gca,'XTickLabel',[]);
ylim([0, LoW(4)]);
%xlabel('Time (30-min interval)');
%ylabel('Wharf length = 450m');
title ('(West Quay)');
%set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
 %    {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;


subplot(5,1,5)       
for i=1:length(results.MILP_BT5)
x1=results.MILP_BT5(i);
x2=results.MILP_BT5(i)+data.pTime(results.MILP_shipAtQ5(i));
y1=results.MILP_BP5(i)+data.LoS(results.MILP_shipAtQ5(i));
y2=results.MILP_BP5(i);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
if BQ_MILP(results.MILP_shipAtQ5(i))==data.PBQ(results.MILP_shipAtQ5(i))
    plot(x, y, 'b', 'LineWidth', 1);
else
    plot(x, y, 'r-', 'LineWidth', 2);
end
txt=[int2str(results.MILP_shipAtQ5(i))]; % SS1 shows sequence of ships,,, ship number
text(x2+2,(y1+y2)/2,txt)
hold on;
xlim([0, 336]);
%set(gca,'XTickLabel',[]);
ylim([0, LoW(5)]);
xlabel('Time (30-min interval)');
%ylabel('Wharf length = 450m');
title ('(North Quay)');
set(gca,'XTick',[0 48 96 144 192 240 288 336],'XTickLabel',...
     {'0','48','96','144','192','240','288','336'});
box on;
grid on;
end
hold off;




figure		
stairs(1:28,BP_CSA ,'LineWidth',1.4, 'Marker','d','MarkerFaceColor','c');		
hold on		
stairs(1:28,BP_GA,'LineWidth',1.4, 'Marker','o','MarkerFaceColor','b');		
hold on
stairs(1:28,BP_PSO ,'*-','LineWidth',1.4);		
hold on
stairs(1:28,BP_MILP ,'G*-','LineWidth',1.4);		
hold on
stairs(1:28,data.PBP,'-.or','LineWidth',1.4);		
hold on		
xlabel('Arriving ships');		
ylabel('Length of 5 Quays (450, 800, 480, 770, 430)');		
legend('BP by CSA','BP by GA','BP by PSO','BP by MILP','Random PBP');		
legend('Location','NorthEast');		
%title('Load per Hour');		
set(gca,'YTick',[0 450 1250 1730 2500 2930],'YTickLabel',...
     {'0', '450','800','480','770','430'});
set(gca,'XTick',[1 3 5 7 9 11 13 15 17 19 21 23 25 27],'XTickLabel',...
     {'1', '3','5','7','9','11','13','15','17','19','21','23','25','27'});
grid on	




% figure				
% ax=plotyy(1:28, waitingTime_CSA,1:28,data.pTime,@stairs,@stairs);
% hold on		
% stairs(1:28,waitingTime_GA,'LineWidth',1.4, 'Marker','o','MarkerFaceColor','b');		
% hold on
% stairs(1:28,waitingTime_PSO ,'*-','LineWidth',1.4);		
% hold on
% stairs(1:28,waitingTime_MILP ,'G*-','LineWidth',1.4);		
% hold on
% set (ax(1),'color','b');
% ylabel(ax(2),'Service time of ships (30-min slots)');
% xlabel('Time (hours)');		
% ylabel('cents/kWh');		
% %set(gca, 'XTick',1:24, 'XTickLabel',{'1' '2' '3' '4' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21' '22' '23' '24'})		
% legend('WT by CSA','WT by GA', 'WT by PSO', 'WT by MILP');		
% legend('Location','NorthEast');
% hold on 

%           WAITING TIME PLOT

%plot4                  Waiting time
figure
bpcombined = [waitingTime_CSA(:), waitingTime_GA(:), waitingTime_PSO(:), waitingTime_MILP(:)]; 
hb = bar(bpcombined, 'grouped');
hold on
xlabel('Arriving vessels in one week');
ylabel('Time (30-minutes interval)');
set(gca,'XTick',[1 3 5 7 9 11 13 15 17 19 21 23 25 27],'XTickLabel',...
     {'1', '3','5','7','9','11','13','15','17','19','21','23','25','27'});
legend('WT by CSA','WT by GA', 'WT by PSO', 'WT by MILP','Location','northwest');
%xlim([0 10]);
grid on	

%                       Total COST

figure
cost=[Total_cost_CSA Total_cost_GA Total_cost_PSO Total_cost_MILP;
    20290 21910 22860 0;
    54310 63445 60865 0;];

%cost = [54310 20290 Total_cost_CSA; 
 %   63445 21910 Total_cost_GA; 
  %  60865 22860 Total_cost_PSO; 
   % 0 0 Total_cost_MILP;]; % cost
%X_as = categorical({'CSA' , 'GA', 'PSO', 'MILP'});
HB = bar(cost , 'grouped');
a = (1:size(cost,2)).';
x = [a-0.25 a a+0.25];
set(gca,'XTick',[1 2 3],'XTickLabel',...
     {'One week','Two weeks', 'Four weeks'});
legend('CSA', 'GA','PSO','MILP');
%annotation("textarrow",[0.7657 0.7835],[0.5134 0.1627],"String",["MILP cannot solve &","runs out of memory in","case of 2-weeks and","1-month scenarios"])
ylabel('Total service cost (euro)');
%xlabel('Algorithms');
%for k=1:size(cost,2)
%for m = 1:size(cost,1)
%text(x(k,m),cost(k,m),num2str(cost(k,m)),...
%'HorizontalAlignment','center',...
%'VerticalAlignment','bottom')
%end
%end


%%%%%%%%    NEW PLOT departures
dep_CSA=BT_CSA+data.pTime;
dep_GA=BT_GA+data.pTime;
dep_PSO=BT_PSO+data.pTime;
dep_MILP=BT_MILP+data.pTime;

figure
bpcombined = [data.dep(:), dep_CSA(:), dep_GA(:), dep_PSO(:), dep_MILP(:)]; 
hb = bar(bpcombined, 'grouped');
hold on
xlabel('Arriving vessels in one week');
ylabel('Time (30-minutes interval)');
set(gca,'XTick',[1 3 5 7 9 11 13 15 17 19 21 23 25 27],'XTickLabel',...
     {'1', '3','5','7','9','11','13','15','17','19','21','23','25','27'});
legend('Requested departure time','Proposed by CSA','Proposed by GA', 'Proposed by PSO', 'Proposed by MILP','Location','northwest');
%xlim([0 10]);
grid on	



%%%%%%%%%%%%%%%%%%%%%%%% new cost plot


all_cost_CSA= [Total_cost_CSA 20290 54310];
    all_cost_GA= [Total_cost_GA 21910 63445];
    all_cost_PSO= [ Total_cost_PSO 22860 60865]; 
    all_cost_MILP= [Total_cost_MILP inf inf]; % cost
figure		
plot(1:3,all_cost_CSA ,'LineWidth',1.4, 'Marker','d','MarkerFaceColor','c');		
hold on		
plot(1:3,all_cost_GA,'LineWidth',1.4, 'Marker','o','MarkerFaceColor','b');		
hold on
plot(1:3,all_cost_PSO ,'*-','LineWidth',1.4);		
hold on
plot(1:3,all_cost_MILP ,'G*-','LineWidth',1.4);		
hold on
annotation("textarrow",[0.239509523809523 0.139880952380952],[0.326098412698414 0.157936507936508],"String",["MILP cannot solve &","runs out of memory in","case of 2-weeks and","1-month scenarios"])
xlabel('Planning horizon');		
ylabel('Total cost (euro)');		
legend('BP by CSA','BP by GA','BP by PSO','BP by MILP');		
legend('Location','SouthEast');		
%title('Load per Hour');		
%set(gca,'YTick',[0 450 1250 1730 2500 2930],'YTickLabel',...
 %    {'0', '450','800','480','770','430'});
set(gca,'XTick',[0 1 2 3],'XTickLabel',...
     {'0', '1-week', '2-weeks','4-weeks'});
grid on	













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





figure
x = 1:1:3;
y = [20 30 45]; % cost
err = 8*ones(size(y));
errorbar(x,y,err)




%%%%%%%%%%%%%%%%%%%%%% DEPARTURE ERROR plot
diff_dep_CSA_1week=data.dep-dep_CSA;
diff_dep_GA_1week=data.dep-dep_GA;
diff_dep_PSO_1week=data.dep-dep_PSO;
diff_dep_MILP_1week=data.dep-dep_MILP;

std_CSA=std(diff_dep_CSA_1week);
std_GA=std(diff_dep_GA_1week);
std_PSO=std(diff_dep_PSO_1week);
std_MILP=std(diff_dep_MILP_1week);

% one week MEAN departures
mean_CSA_1week=mean(diff_dep_CSA_1week);
mean_GA_1week=mean(diff_dep_GA_1week);
mean_PSO_1week=mean(diff_dep_PSO_1week);
mean_MILP_1week=mean(diff_dep_MILP_1week);
% ERROR one week
stderror_CSA_1week=std(diff_dep_CSA_1week)/sqrt(length(diff_dep_CSA_1week));
stderror_GA_1week=std(diff_dep_GA_1week)/sqrt(length(diff_dep_GA_1week));
stderror_PSO_1week=std(diff_dep_PSO_1week)/sqrt(length(diff_dep_PSO_1week));
stderror_MILP_1week=std(diff_dep_MILP_1week)/sqrt(length(diff_dep_MILP_1week));




% four weeks MEAN DEPARTURES
mean_CSA_4week=3.21;
mean_GA_4week=2.30;
mean_PSO_4week=2.22;
% error two weeks
stderror_CSA_4week=0.33;
stderror_GA_4week=0.23;
stderror_PSO_4week=0.30;


% Two weeks MEAN DEPARTURES
mean_CSA_2week=3.94;
mean_GA_2week=3.10;
mean_PSO_2week=3.55;
% error two weeks
stderror_CSA_2week=0.5929;
stderror_GA_2week=0.4723;
stderror_PSO_2week=0.5273;

% new dep plot

figure
diff_dep = [std_CSA mean_CSA_1week; 
    std_GA mean_GA_1week;
    std_PSO mean_PSO_1week;
    std_MILP mean_MILP_1week;]; % cost
%X_as = categorical({'CSA' , 'GA', 'PSO', 'MILP'});
HB = bar(diff_dep , 'grouped');
a = (1:size(diff_dep,1)).';
x = [a-0.25 a a+0.25];
set(gca,'XTick',[1 2 3 4],'XTickLabel',...
     {'CSA', 'GA','PSO','MILP'});
legend('Standard deviation','Mean');
ylabel('Early departures');
xlabel('Algorithms');






%%%%%%%%%%%%%%%%%%%     WAITING TIME ERROR plot
% 1 week
mean_CSA_1week_WT=mean(waitingTime_CSA);
mean_GA_1week_WT=mean(waitingTime_GA);
mean_PSO_1week_WT=mean(waitingTime_PSO);
mean_MILP_1week_WT=mean(waitingTime_MILP);
% error 1 week waiting time
stderror_CSA_1week_WT=std(waitingTime_CSA)/sqrt(length(waitingTime_CSA));
stderror_GA_1week_WT=std(waitingTime_GA)/sqrt(length(waitingTime_GA));
stderror_PSO_1week_WT=std(waitingTime_PSO)/sqrt(length(waitingTime_PSO));
stderror_MILP_1week_WT=std(waitingTime_MILP)/sqrt(length(waitingTime_MILP));

% 2 weeks
mean_CSA_2week_WT=0.54;
mean_GA_2week_WT=1.38;
mean_PSO_2week_WT=0.94;
% error two weeks waiting times
stderror_CSA_2week_WT=0.08;
stderror_GA_2week_WT=0.27;
stderror_PSO_2week_WT=0.18;


% 4 weeks
mean_CSA_4week_WT=0.69;
mean_GA_4week_WT=1.61;
mean_PSO_4week_WT=1.69;

% ERROR four week waiting times
stderror_CSA_4week_WT=0.067;
stderror_GA_4week_WT=0.18;
stderror_PSO_4week_WT=0.17;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% diff BERTHING POSITIONS DATA
% Difference between optimal and proposed berthing position
diff_berthing_POS_CSA_1week=abs(data.PBP-BP_CSA);
diff_berthing_POS_GA_1week=abs(data.PBP-BP_GA);
diff_berthing_POS_PSO_1week=abs(data.PBP-BP_PSO);
diff_berthing_POS_MILP_1week=abs(data.PBP-BP_MILP);
% I DID MANUALLY THINGS SUGGESTED BY DR. HERODOTOU
% Add a new figure and paragraph describing the difference between proposed and optimal berthing position. This metric will apply only for the vessels that were berthed on the PBQ. You should say how many vessels were berthed on the ABQ in each scenario.
diff_berthing_POS_CSA_1week(21)=0;
diff_berthing_POS_GA_1week(23)=0;
diff_berthing_POS_PSO_1week(21)=0;
diff_berthing_POS_MILP_1week(23)=0;
% STD of berthing position
std_CSA_diff_berthing_POS_1week=std(diff_berthing_POS_CSA_1week);
std_GA_diff_berthing_POS_1week=std(diff_berthing_POS_GA_1week);
std_PSO_diff_berthing_POS_1week=std(diff_berthing_POS_PSO_1week);
std_MILP_diff_berthing_POS_1week=std(diff_berthing_POS_MILP_1week);

%    MEAN of berthing positions
mean_CSA_diff_berthing_POS_1week=mean(diff_berthing_POS_CSA_1week);
mean_GA_diff_berthing_POS_1week=mean(diff_berthing_POS_GA_1week);
mean_PSO_diff_berthing_POS_1week=mean(diff_berthing_POS_PSO_1week);
mean_MILP_diff_berthing_POS_1week=mean(diff_berthing_POS_MILP_1week);

% ERROR one week
stderror_CSA_diff_berthing_POS_1week=std(diff_berthing_POS_CSA_1week)/sqrt(length(diff_berthing_POS_CSA_1week));
stderror_GA_diff_berthing_POS_1week=std(diff_berthing_POS_GA_1week)/sqrt(length(diff_berthing_POS_GA_1week));
stderror_PSO_diff_berthing_POS_1week=std(diff_berthing_POS_PSO_1week)/sqrt(length(diff_berthing_POS_PSO_1week));
stderror_MILP_diff_berthing_POS_1week=std(diff_berthing_POS_MILP_1week)/sqrt(length(diff_berthing_POS_MILP_1week));

% 2 WEEK
% MEAN
mean_CSA_diff_berthing_POS_2week=0.9853;
mean_GA_diff_berthing_POS_2week=2.9412;
mean_PSO_diff_berthing_POS_2week=9.2647;
% ERROR
stderror_CSA_diff_berthing_POS_2week=0.2892;
stderror_GA_diff_berthing_POS_2week=0.4513;
stderror_PSO_diff_berthing_POS_2week=1.1222;

%  4 WEEK
% MEAN
mean_CSA_diff_berthing_POS_4week=1.1957;
mean_GA_diff_berthing_POS_4week=5.7826;
mean_PSO_diff_berthing_POS_4week=16.1913;

% ERROR
stderror_CSA_diff_berthing_POS_4week=0.3804;
stderror_GA_diff_berthing_POS_4week=0.6515;
stderror_PSO_diff_berthing_POS_4week=6.9752;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% diff NOB COST DATA
% Difference between optimal and NON-OPTIMAL BERTHING COST
diff_berthing_POS_cost_CSA_1week=NOB_cost_CSA;
diff_berthing_POS_cost_GA_1week=NOB_cost_GA;
diff_berthing_POS_cost_PSO_1week=NOB_cost_PSO;
diff_berthing_POS_cost_MILP_1week=NOB_cost_MILP;

% MEAN 1 week
mean_CSA_diff_berthing_POS_cost_1week=mean(diff_berthing_POS_cost_CSA_1week);
mean_GA_diff_berthing_POS_cost_1week=mean(diff_berthing_POS_cost_GA_1week);
mean_PSO_diff_berthing_POS_cost_1week=mean(diff_berthing_POS_cost_PSO_1week);
mean_MILP_diff_berthing_POS_cost_1week=mean(diff_berthing_POS_cost_MILP_1week);


% ERROR one week
stderror_CSA_diff_berthing_POS_cost_1week=std(diff_berthing_POS_cost_CSA_1week)/sqrt(length(diff_berthing_POS_cost_CSA_1week));
stderror_GA_diff_berthing_POS_cost_1week=std(diff_berthing_POS_cost_GA_1week)/sqrt(length(diff_berthing_POS_cost_GA_1week));
stderror_PSO_diff_berthing_POS_cost_1week=std(diff_berthing_POS_cost_PSO_1week)/sqrt(length(diff_berthing_POS_cost_PSO_1week));
stderror_MILP_diff_berthing_POS_cost_1week=std(diff_berthing_POS_cost_MILP_1week)/sqrt(length(diff_berthing_POS_cost_MILP_1week));


% 2 weeks
% mean
mean_CSA_diff_berthing_POS_cost_2week=7.13;
mean_GA_diff_berthing_POS_cost_2week=26.76;
mean_PSO_diff_berthing_POS_cost_2week=42.35;
% ERROR
stderror_CSA_diff_berthing_POS_cost_2week=1.82;
stderror_GA_diff_berthing_POS_cost_2week=2.56;
stderror_PSO_diff_berthing_POS_cost_2week=4.23;


% 4 weeks
% mean
mean_CSA_diff_berthing_POS_cost_4week=18.69;
mean_GA_diff_berthing_POS_cost_4week=80.61;
mean_PSO_diff_berthing_POS_cost_4week=59.49;
% ERROR
stderror_CSA_diff_berthing_POS_cost_4week=1.92;
stderror_GA_diff_berthing_POS_cost_4week=30.74;
stderror_PSO_diff_berthing_POS_cost_4week=5.66;




close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New error plot difference from optimal departure
figure
mean_departure=[mean_CSA_1week mean_GA_1week mean_PSO_1week mean_MILP_1week;
    mean_CSA_2week mean_GA_2week mean_PSO_2week 0;
    mean_CSA_4week mean_GA_4week mean_PSO_4week 0];

model_error_dep = [stderror_CSA_1week stderror_GA_1week stderror_PSO_1week stderror_MILP_1week;
    stderror_CSA_2week stderror_GA_2week stderror_PSO_2week 0;
    stderror_CSA_4week stderror_GA_4week stderror_PSO_4week 0]; 
b = bar(mean_departure, 'grouped');
hold on
% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(mean_departure);
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
% Plot the errorbars
errorbar(x',mean_departure,model_error_dep,'k','linestyle','none');

% legends
set(gca,'XTick',[1 2 3],'XTickLabel',...
     {'One week','Two weeks', 'Four weeks'});
legend('CSA', 'GA','PSO','MILP');
ylabel('Difference from optimal departure');



mean_MILP_1week_WT=0.01; % temp value based on Dr. Michali and herodotou suggestion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New error plot difference from optimal berthing time
figure
mean_waitingTime = [mean_CSA_1week_WT mean_GA_1week_WT mean_PSO_1week_WT mean_MILP_1week_WT;
    mean_CSA_2week_WT mean_GA_2week_WT mean_PSO_2week_WT 0;
    mean_CSA_4week_WT mean_GA_4week_WT mean_PSO_4week_WT 0]; 

model_error = [stderror_CSA_1week_WT stderror_GA_1week_WT stderror_PSO_1week_WT stderror_MILP_1week_WT;
    stderror_CSA_2week_WT stderror_GA_2week_WT stderror_PSO_2week_WT 0;
    stderror_CSA_4week_WT stderror_GA_4week_WT stderror_PSO_4week_WT 0]; 
b = bar(mean_waitingTime, 'grouped');
hold on
% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(mean_waitingTime);
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
% Plot the errorbars
errorbar(x',mean_waitingTime,model_error,'k','linestyle','none');

% legends
set(gca,'XTick',[1 2 3],'XTickLabel',...
     {'One week','Two weeks', 'Four weeks'});
legend('CSA', 'GA','PSO','MILP');
ylabel('Difference from optimal berthing time (30-min interval)');
hold off







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New error plot difference from optimal berthing POSITION
figure
mean_berthingPOS= [mean_CSA_diff_berthing_POS_1week mean_GA_diff_berthing_POS_1week mean_PSO_diff_berthing_POS_1week mean_MILP_diff_berthing_POS_1week;
    mean_CSA_diff_berthing_POS_2week mean_GA_diff_berthing_POS_2week mean_PSO_diff_berthing_POS_2week 0;
    mean_CSA_diff_berthing_POS_4week mean_GA_diff_berthing_POS_4week mean_PSO_diff_berthing_POS_4week 0]; 


model_error = [stderror_CSA_diff_berthing_POS_1week stderror_GA_diff_berthing_POS_1week stderror_PSO_diff_berthing_POS_1week stderror_MILP_diff_berthing_POS_1week;
    stderror_CSA_diff_berthing_POS_2week stderror_GA_diff_berthing_POS_2week stderror_PSO_diff_berthing_POS_2week 0;
    stderror_CSA_diff_berthing_POS_4week stderror_GA_diff_berthing_POS_4week stderror_PSO_diff_berthing_POS_4week 0]; 
b = bar(mean_berthingPOS, 'grouped');
hold on
% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(mean_berthingPOS);
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
% Plot the errorbars
errorbar(x',mean_berthingPOS,model_error,'k','linestyle','none');

% legends
set(gca,'XTick',[1 2 3],'XTickLabel',...
     {'One week','Two weeks', 'Four weeks'});
legend('CSA', 'GA','PSO','MILP');
ylabel('Difference from optimal berthing position (m)');
hold off








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% New ERROR PLOT FOR NON_OPTIMAL BERTH POSITION COST that included position and quay

figure
mean_berthingPOS_cost= [mean_CSA_diff_berthing_POS_cost_1week mean_GA_diff_berthing_POS_cost_1week mean_PSO_diff_berthing_POS_cost_1week mean_MILP_diff_berthing_POS_cost_1week;
    mean_CSA_diff_berthing_POS_cost_2week mean_GA_diff_berthing_POS_cost_2week mean_PSO_diff_berthing_POS_cost_2week 0;
    mean_CSA_diff_berthing_POS_cost_4week mean_GA_diff_berthing_POS_cost_4week mean_PSO_diff_berthing_POS_cost_4week 0]; 


model_error = [stderror_CSA_diff_berthing_POS_cost_1week stderror_GA_diff_berthing_POS_cost_1week stderror_PSO_diff_berthing_POS_cost_1week stderror_MILP_diff_berthing_POS_cost_1week;
    stderror_CSA_diff_berthing_POS_cost_2week stderror_GA_diff_berthing_POS_cost_2week stderror_PSO_diff_berthing_POS_cost_2week 0;
    stderror_CSA_diff_berthing_POS_cost_4week stderror_GA_diff_berthing_POS_cost_4week stderror_PSO_diff_berthing_POS_cost_4week 0]; 
b = bar(mean_berthingPOS_cost, 'grouped');
hold on
% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(mean_berthingPOS_cost);
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
% Plot the errorbars
errorbar(x',mean_berthingPOS_cost,model_error,'k','linestyle','none');

% legends
set(gca,'XTick',[1 2 3],'XTickLabel',...
     {'One week','Two weeks', 'Four weeks'});
legend('CSA', 'GA','PSO','MILP');
ylabel('Non optimal berthing cost (euro)');
hold off