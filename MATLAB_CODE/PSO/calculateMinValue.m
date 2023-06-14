function [min_ObjVal, bestNest_so_Far]= calculateMinValue(fmin,fnew1,fnew2,bestNest,best1,best2)

    if fmin<fnew1 && fmin<fnew2
        min_ObjVal=fmin;
       bestNest_so_Far= bestNest;
    elseif fnew1<fmin && fnew1<fnew2
       min_ObjVal=fnew1;
       bestNest_so_Far= best1;
        else
       min_ObjVal=fnew2;
       bestNest_so_Far=best2;    
    end