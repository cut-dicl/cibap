function [solution ] = mutateSwap(solution, data, LoW)
prefferingBerth=data.PBP;M=5; PBQ=data.PBQ;



BT=solution(1:length(solution)/3); % bt is berthing time
rand1=randi([1, length(BT)]);
rand3=randi([data.AT(rand1),max(data.AT(rand1), data.dep(rand1)-data.pTime(rand1))]); 
BT(rand1)=rand3;


BP=solution(length(BT)+1:length(BT)*2);
rand2=randi([1, length(BP)]);
rand4=randi([ (max( sum(LoW(1:PBQ(rand2)-1)), (prefferingBerth(rand2)-M))),       max((max( sum(LoW(1:PBQ(rand2)-1)), (prefferingBerth(rand2)-M))), (min(sum(LoW(1:PBQ(rand2)))-data.LoS(rand2),  prefferingBerth(rand2)+M)))]);
BP(rand2)=rand4;


BQ=solution(length(BT)+length(BP)+1:end);
rand1=randi([1, length(BQ)]);
rand3=randi([min(data.PBQ(rand1),data.ABQ(rand1)), max(data.PBQ(rand1),data.ABQ(rand1))]); 
BQ(rand1)=rand3;

solution=[BT BP BQ]; % here p is a berthing position

