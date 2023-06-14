
function [PSO_BestPosition PSO_BestCost Quay]=PSO(data, LoW, costs);



%%                   Problem parameters initilization

AT=data.AT; % arrival time
LoS=data.LoS; % length of ship
lambda=0.8;
PBP=data.PBP;
PBQ=data.PBQ; % preferred berthing position .... Lowest cost berthing positions
alfa=ones(size(AT));
M=40;
it=0; PBQ_changed=[];
departure=data.dep; % departure times of ships
pTime=data.pTime; % processing time of all vessels to unload or load
% Bays: The bay-row-tier system follows a system of numerical coordinates relating to length, width and height. The stowage space of the container on board the ship is unambiguously stated in numbers and is (almost always) recorded in the shipping documents. It is then also possible to establish at a later date where the container was carried during maritime transport.
%       According to this principle, bays are the container blocks in the transverse direction, rows are the lengthwise rows and tiers are the vertical layers.


CostFunction=@(data,x,LoW,it,i,PBQ_changed, costs) fitnessfunction(data,x,LoW,it,i,PBQ_changed, costs);        % Cost Function

%% PSO Parameters
nVar=length(AT)*3;            % Number of Decision Variables

VarSize=[1 nVar];   % Size of Decision Variables Matrix
VarMin=-10;         % Lower Bound of Variables
VarMax= 10;         % Upper Bound of Variables

MaxIt=1000;      % Maximum Number of Iterations

nPop=100;        % Population Size (Swarm Size)

% PSO Parameters
w=1;            % Inertia Weight
wdamp=0.99;     % Inertia Weight Damping Ratio
c1=1.5; % 2.5; %1.5;         % Personal Learning Coefficient
c2=2.0; % 4.5; %2.0;         % Global Learning Coefficient

% If you would like to use Constriction Coefficients for PSO,
% uncomment the following block and comment the above set of parameters.

% % Constriction Coefficients
% phi1=2.05;
 %phi2=2.05;
 %phi=phi1+phi2;
 %chi=2/(phi-2+sqrt(phi^2-4*phi));
 %w=chi;          % Inertia Weight
 %wdamp=3;        % Inertia Weight Damping Ratio
 %c1=chi*phi1;    % Personal Learning Coefficient
 %c2=chi*phi2;    % Global Learning Coefficient

% Velocity Limits
VelMax=0.1*(VarMax-VarMin); %310.1*
VelMin=-VelMax;


%% Initialization

empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
%empty_particle.pos2=[];
empty_particle.Best.Cost=[];

particle=repmat(empty_particle,nPop,1);

GlobalBest.Cost=inf;


%swarm=populationSize;
%[BT BP Quay]=random_population(LoS, PBQ, AT, departure, pTime, LoW, nPop);
[BT BP BQ]=random_population(LoS, data.AT, data.dep, pTime, LoW, PBP, PBQ, nPop); % random population generation
 
NewPop=[BT BP BQ];

for i=1:nPop
    
    % Initialize Position
    particle(i).Position=NewPop(i,:);
    x=particle(i).Position;
    % Initialize Velocity
    particle(i).Velocity=zeros(VarSize);
    
    % Evaluation
    particle(i).Cost=CostFunction(data,x,LoW,it,i,PBQ_changed, costs);
    
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    
    % Update Global Best
    if particle(i).Best.Cost<GlobalBest.Cost
        
        GlobalBest=particle(i).Best
     end
    
end



BestCost=zeros(MaxIt,1);

%% PSO Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        % Update Velocity
        particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        
        % Apply Velocity Limits
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        
        % Update Position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Velocity Mirror Effect
        %IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
        %particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
        
        % Apply Position Limits
        %particle(i).Position = max(particle(i).Position,VarMin);
        %particle(i).Position = min(particle(i).Position,VarMax);
        
        
        % Evaluation
        xx=abs(round(particle(i).Position));
        if i==1
            xx=GlobalBest.Position;
        elseif it>400 && i==2
            xx=pos;
        end
        bt=xx(1:length(AT));
        bp=xx(length(AT)+1:length(AT)*2);
        bq=xx(length(AT)*2+1:end);
        %for gg=1:length(AT)
         %   bp(gg)=bp(gg)*randi([1,3]);
        %end

        xx=[bt bp bq];
        [Cost pos PBQ_changed data] = CostFunction(data,xx,LoW, it,i,PBQ_changed, costs);
        particle(i).Cost=Cost;
        particle(i+1).Position=pos;
        % Update Personal Best
        if particle(i).Cost<=particle(i).Best.Cost
            
            particle(i).Best.Position=pos;
            particle(i).Best.Cost=particle(i).Cost;
            
            % Update Global Best
            if particle(i).Best.Cost<GlobalBest.Cost
                
                GlobalBest=particle(i).Best;
                
            end
            
        end
        
    end
    
    BestCost(it)=GlobalBest.Cost;
    BestSolution=GlobalBest.Position;
    
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    w=w*wdamp;
    
end

BestSol = GlobalBest;
PSO_BestPosition=GlobalBest.Position;
PSO_BestCost=GlobalBest.Cost;
