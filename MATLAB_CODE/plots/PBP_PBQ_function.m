function [PBQ ABQ PBP]=PBP_PBQ_function(LoS, PBQ_name, AT, LoW);

% preferred berthing position and Converting PBQ (charecter value) to PBQ (number value)
for i=1:length(AT)

 if PBQ_name(i) =="Container/ Ro-Ro Quay" % length 450
                PBQ(i) =1;
                ABQ(i) =2; % alternative berthing quay for 1st (container/ ro-ro quay)
                PBP(i)=randi([0, LoW(PBQ(i))-LoS(i)]); % preferred berthing position is generated based on preferred quay
            elseif PBQ_name(i) =="Container Quay"  % length 800
                PBQ(i) =2;
                ABQ(i) =1;
                PBP(i)=randi([sum(LoW(1:PBQ(i)-1))+1, sum(LoW(1:PBQ(i)))-LoS(i)]); % preferred berthing position is generated based on preferred quay
            elseif PBQ_name(i) =="East Quay"  % length 480
                PBQ(i) =3;
                ABQ(i) =3; % we have added ABQ also 0, because, there is no alternative quay for East Quay
                PBP(i)=randi([sum(LoW(1:PBQ(i)-1))+1, sum(LoW(1:PBQ(i)))-LoS(i)]); % preferred berthing position is generated based on preferred quay

            elseif PBQ_name(i) =="West Quay"  % length 770
                PBQ(i) =4;
                ABQ(i) =5;
                PBP(i)=randi([sum(LoW(1:PBQ(i)-1))+1, sum(LoW(1:PBQ(i)))-LoS(i)]); % preferred berthing position is generated based on preferred quay
            elseif PBQ_name(i) =="North Quay"  % length 430
                PBQ(i) =5;
                ABQ(i) =4;
                PBP(i)=randi([sum(LoW(1:PBQ(i)-1))+1, sum(LoW(1:PBQ(i)))-LoS(i)]); % preferred berthing position is generated based on preferred quay
 end
    

%PBP(i)=randi([0, LoW(PBQ(i))-LoS(i)]); % preferred berthing position is generated based on preferred quay
end