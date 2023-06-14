function [BT BP BQ_n]=Jump_places_overlapig(Ship_search_space_jump, iii,pTime, AT, ABQ, BQ, LoS, PBP, PBQ, BT, BP,lengthOfwharf)

if rem(length(Ship_search_space_jump),2)==0
     BP_jumped=0;
           for i=1:length(Ship_search_space_jump)
            if rem(i,2)==0   % EVERY 2 ships overlap ho re hain...therefore, we will change bq of one ship
                %if any(ShipNo_BQChange(i)==PBQ_changed)==false % || PBQ_changed ==[] %==false % any(ShipNo_BQChange(1)~=PBQ_changed(1))==true %ShipNo_BQChange~=1......any(1)~=1==true
                %if any(ShipNo_BQChange(i-1)==PBQ_changed)==false    
                    % b=randi([1,2]);            %[minnn, Index]=min(LoS(ShipNo_BQChange(1)), LoS(ShipNo_BQChange(2)));
                    pp=[Ship_search_space_jump(i-1) Ship_search_space_jump(i)]; %% pp contains two overlaping ships and one of them needs to change its BQ
                    [min_pTime, b]=min(pTime(pp)); % finding max time and location
                    % new tamasha
                    s1=find(BQ==PBQ(pp(b))); % it contains ships having the same PBQ
                    s2=find(BT(s1)>=BT(pp(b))); % it finds ships having at after at of that ship that is going to change its bq
                    s2_=s1(s2);
                    s3=find(BT(s1)<BT(pp(b))+pTime(pp(b))); %ships having AT after than overlapping ship
                    s3_=s1(s3);
                    s4=find(BT(s3_)+pTime(s3_)>BT(pp(b)));
                    s4_=s3_(s4);
                    common1=intersect(s2_,s3_);
                    common2=intersect(s3_,s4_);
                    common3=union(common1,common2);
                    [j,k]=sort(BP(common3),'ascend'); % sorting the solutions
                

                if length(common3)>1    
                    for l=1:length(common3)-1
                        %BP_jumped=0;
                           if (BP(common3(k(l)))+LoS(common3(k(l))))< BP(common3(k(l+1))) && abs((BP(common3(k(l)))+LoS(common3(k(l))))-BP(common3(k(l+1)))) >LoS(pp(b)) % agr in between other ships, there is any space for affected ship
                                BP_jumped=randi([(BP(common3(k(l)))+LoS(common3(k(l))))+1, BP(common3(k(l+1)))-LoS(pp(b))]);
                                break;
                           elseif (BP(common3(k(1)))-sum(lengthOfwharf(1:PBQ(pp(b))-1))) > LoS(pp(b))% agr affected ship k nechy space h to
                                BP_jumped=randi([sum(lengthOfwharf(1:PBQ(pp(b))-1)), BP(common3(k(1)))-LoS(pp(b))]);
                                break;
                           elseif sum(lengthOfwharf(1:PBQ(pp(b))))-max(BP(common3)+LoS(common3)') > LoS(pp(b)) % agr affected ship k ooper space h to
                                BP_jumped=randi([max(BP(common3)+LoS(common3)'), sum(lengthOfwharf(1:PBQ(pp(b))))-LoS(pp(b))]);
                                break;
                           end
                    end
                elseif length(common3)==1   % ELSE only 1 disturbing vessel
                   if (BP(common3(k(1)))-sum(lengthOfwharf(1:PBQ(pp(b))-1))) > LoS(pp(b))
                         BP_jumped=randi([sum(lengthOfwharf(1:PBQ(pp(b))-1)), BP(common3(k(1)))-LoS(pp(b))]);
                   elseif sum(lengthOfwharf(1:PBQ(pp(b))))-(BP(common3(k(1)))+LoS(common3(k(1)))) > LoS(pp(b))
                       BP_jumped=randi([(BP(common3(k(1)))+LoS(common3(k(1)))),sum(lengthOfwharf(1:PBQ(pp(b))))]);
                   end
                end
                if BP_jumped>0
                    BP(pp(b))=BP_jumped;
                end

%                     max_posb_plac=max(BP(common3)+LoS(common3));
%                     min_posb_plac=min(BP(common3));
%                     if common3>0
%                         if sum(lengthOfwharf(1:PBQ(pp(b))))-LoS(pp(b)) > max_posb_plac
%                             BP(pp(b))=randi([max_posb_plac, sum(lengthOfwharf(1:PBQ(pp(b))))-LoS(pp(b))]);
%                         elseif min_posb_plac >= sum(lengthOfwharf(1:PBQ(pp(b))-1))+LoS(pp(b))
%                             BP(pp(b))=randi([sum(lengthOfwharf(1:PBQ(pp(b))-1)), min_posb_plac-LoS(pp(b))]);
%                         end
%                    end
%                    %end       %end
            end
            %[x1]=mainplot(BT, BP, pTime, LoS, 1, 48); % plot
           end
end




%%%%%%%%%
BQ_n=BQ;
for i=1:length(BQ_n) 
if BQ(i)==ABQ(i) % if proposed quay is ABQ, a fixed penalty is added
    BQ_n(i)=randi([min(PBQ(i),ABQ(i)), max(PBQ(i),ABQ(i))]);
elseif  BQ(i)==PBQ(i) % if proposed quay id preferred quay penalty maybe 0 or defined based on preferred berthing position
 BQ_n(i)=BQ(i);
else % if proposed quay is neither preferred not ABQ, an infinite penalty is added
   BQ_n(i)=randi([min(PBQ(i),ABQ(i)), max(PBQ(i),ABQ(i))]);
end
end