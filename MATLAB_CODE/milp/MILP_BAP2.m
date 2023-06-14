function [BTfinal_MILP, BPfinal_MILP,BQ_MILP] = MILP_BAP2(data, LoW)
% This Code is written by Sheraz Aslam (PhD student) for berth scheduling problem
 

%                           Linear programming
%   Linear Programming (LP) is an attempt to find a maximum or minimum solution to a function,...
%   given certain constraints. These constraints have to be linear. You cannot have parametric...
%   of hyperbolic constraints. We can solve these in polynomial time.
%   For help-------______   "https://www.mathworks.com/help/optim/ug/linprog.html"

%                           Integer Programming
%   Integer Programming is a subset of Linear Programming. It has all the characteristics of ...
%   an LP except for one caveat: the solution to the LP must be restricted
%   to integers. We can't solve these in polynomial time.

%                                MILP
%   An LP (linear program) involves minimizing (or maximizing) a linear function subject to linear...
%   constraints on the variables. Any solution that satisfies the constraints is feasible. A MILP...
%   is an LP with the addition of integrality restrictions on some or all of the variables.
%   simply mean's some variables are linear (contineous) and some are discrete



pTime= data.pTime;%Datatable.ProcessingTimeOfVessel;
LoS=data.LoS; %Datatable.LengthOfVessel;
totalSlots=48*data.days; % 7 days implementation * 48 slots in a day (30-min time interval)

% this function is used to making milp problem (creating require values
% for intlinprog function
[f,A,b,Aeq,beq,shipNumberVector,AA,Solution_VLength,BQ_MILP] = MILP_fun(data,LoW,totalSlots);


nVars = numel(f);  % Number of variables in the problem... numel used for find number of data elements
lb = zeros(nVars,1);    % The upper and lower bounds are 0 and 1
ub = ones(nVars,1);
intcon=nVars;
%                       MILP Area
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               crating a structre for problem/problem formulation

appliance_scheduling_prob = struct('f',f,'intcon',intcon,...
    'Aineq',A,'bineq',b,'Aeq',Aeq,'beq',beq,...
    'lb',lb,'ub',ub,'options',[],...
    'solver','intlinprog');


%%% calling the mixed integer linear programming function (builtin of MATLAB)
[x, cost] = intlinprog(appliance_scheduling_prob);


%[x, cost] = intlinprog(f,1:nVars,A,b,Aeq,beq,lb,ub);
%x = intlinprog(f,1:nVars,A,b)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total_vessels = length(data.AT);%size(Datatable,1); % Total number of vessels

selected = find(x); % find function is used for finding non_zero values

hoursMatrix = zeros(total_vessels,totalSlots); % initialize by 0 appliances x hours

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           creating the matrix of appliance nd hour with minimum cost
abc=0;
for n = 1:numel(selected);
    thisEntry =selected(n);
    thisappliance = shipNumberVector(thisEntry);
    executing_hours = -AA(1:totalSlots,thisEntry); % selected hours
    Sol2=cell2mat(Solution_VLength(n)); thisEntry=thisEntry-abc; abc=abc+size(Sol2,2); 
    executing_positions = Sol2(:,thisEntry); % selected positions
    Sol2_cell{n}=executing_positions;
    hoursMatrix(thisappliance,:) = executing_hours;
    aaaa=find(executing_hours); BTfinal_MILP(n)=aaaa(1); %berthing time finding for ship n
    BPfinal_MILP(n)=executing_positions(1); % berthing time finding against ship n
end