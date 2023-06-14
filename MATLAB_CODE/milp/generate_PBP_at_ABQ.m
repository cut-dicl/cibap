function [PBP_new] = generate_PBP_at_ABQ(cc,n, data, LoW)
% this function is created to generate PBP at the ABQ of any ship

ax=0; bx=0;
for i=1:length(cc)
    if (data.AT(cc(i))<=data.AT(n) && data.AT(cc(i)) + data.pTime(cc(i)) > data.AT(n)) ||...
        (data.AT(cc(i))>=data.AT(n) && data.AT(n) + data.pTime(n)> data.pTime(cc(i)))
        if i==1;     ax=max(ax,data.PBP(cc(i))); %PBP of n
        else;    ax=min(ax,data.PBP(cc(i)));    end
            %%%%
        bx=max(bx,data.PBP(cc(i))+data.LoS(cc(i)));
    end
end

if data.LoS(n)<ax-sum(LoW(1:data.PBQ(n)-1))
    PBP_new=randi([sum(LoW(1:data.PBQ(n)-1)), ax-data.LoS(n)]);
elseif data.LoS(n)<sum(LoW(1:data.PBQ(n)))-bx
    PBP_new=randi([bx, sum(LoW(1:data.PBQ(n)))-data.LoS(n)]);
% I am adding below else temporarly, maybe I need to change it in future
else
    PBP_new=randi([sum(LoW(1:data.PBQ(n)-1)), sum(LoW(1:data.PBQ(n)))]);

end

