function [price2, data] = overlapping_function(data, WharfLength, price2, n)
pp=n-1;
  for iii=1:n-1
if n==15
    dddd=44444; %issue with vessel 10 and 1
end
%pp
        if (data.AT(n)<=data.AT(pp)||...
            (data.AT(n)>=data.AT(pp) && data.AT(n)<data.AT(pp)+data.pTime(pp)))&&... % just modified data.dep(pp) with data.AT(pp)+data.pTime(pp)
            data.AT(n)+data.pTime(n)>data.AT(pp)
    
                if (data.PBP(n)>=data.PBP(pp)...
                    && data.PBP(n)<data.PBP(pp)+data.LoS(pp))...
                    || data.PBP(n)<=data.PBP(pp) && data.PBP(n)+data.LoS(n)>data.PBP(pp)
                    %penality here
                    price2( max( (max(sum(WharfLength(1:data.PBQ(n)-1)), data.PBP(pp)-(data.LoS(n)+2))) ...
                    -sum(WharfLength(1:data.PBQ(n)-1)), 1): ... %
                    min( (data.PBP(pp)+data.LoS(pp)+2)-sum(WharfLength(1:data.PBQ(n)-1)), length(price2)) )=2000;         
% updating pbp based on minim cost place

                        if length(sum(WharfLength(1:data.PBQ(n)-1))+find(price2 == min(price2))) <2 % some time min value nh ati qk sb option he mehngy party hn so we need to modify berthing time in this case
                            data.PBP(n)=sum(WharfLength(1:data.PBQ(n)-1))+find(price2 == min(price2)); % adding new PBP due to overlaping
                        end
                end
        end
pp=pp-1;
  %% 
  end % for ends iii