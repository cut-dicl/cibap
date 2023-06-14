function [BT BP BQ]=random_population(LoS, AT, departure, pTime, LoW, PBP, PBQ, nPop);
M=10;

for k=1:nPop
   for i=1:length(AT)
                                        if AT(i)+pTime(i)>departure(i); departure=departure+1;  end  
       
     BQ(k,i)=randi([1,length(LoW)]);
     BT(k,i)=randi([AT(i),departure(i)-pTime(i)]); % berthing times of vessels  at
     BP(k,i)=randi([max(sum(LoW(1:PBQ(i)-1))+1,(PBP(i)-M)),min(sum(LoW(1:PBQ(i)))-LoS(i),PBP(i)+M)]);  % berthing positions of vessels
   end
end 