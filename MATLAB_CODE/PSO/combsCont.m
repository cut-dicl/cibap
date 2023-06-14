function [p]=combsCont(a,n)
%a=24; n=3; 
b=1; p=[];
for i=1:a-n+1
   generate= b:n;    b=b+1;   n=n+1;
   p=[p; generate];
end