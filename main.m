close all
clear all
clc

tic();


ProblemData=CreateProblemData();

Nvar=ProblemData.N;
Ncolors=ProblemData.NColors; 

Cost=@(x) Costfcn(x,ProblemData);


nPop=20;
maxit=100;


c1=2;
c2=4-c1;



varmin=1;
varmax=Ncolors;

velmin=-Ncolors;
velmax=Ncolors;

w=1;
wdamp=0.99;


BestCost=zeros(1,maxit);


emp.pos=[];
emp.vel=[];
emp.cost=[];

emp.best.cost=[];
emp.best.pos=[];


par=repmat(emp,1,nPop);


Gbest.cost=Inf;
Gbest.pos=[];

for i=1:nPop
    
    par(i).pos=unifrnd(varmin,varmax,[1 Nvar]);
    par(i).vel=zeros(1,Nvar);
    
    par(i).pos=round(par(i).pos);
    
    par(i).cost=Cost(par(i).pos);
    
    
    par(i).best.pos=par(i).pos;
    par(i).best.cost=par(i).cost;
   
    
    if (par(i).cost<Gbest.cost)
        
        Gbest=par(i).best;
        
    end
   
end


for it=1:maxit

for i=1:nPop

    par(i).vel=w*par(i).vel+c1*rand*(Gbest.pos-par(i).pos)+c2*rand*(par(i).best.pos-par(i).pos);
    
    par(i).vel=max(par(i).vel,velmin);
    par(i).vel=min(par(i).vel,velmax);
    
    
    par(i).pos=par(i).pos+par(i).vel;
    
    par(i).pos=max(par(i).pos,varmin);
    par(i).pos=min(par(i).pos,varmax);
    
    
    par(i).pos=round(par(i).pos);
    
   par(i).cost=Cost(par(i).pos);
    
    if par(i).cost<par(i).best.cost
        
         par(i).best.pos=par(i).pos;
    par(i).best.cost=par(i).cost;
   
    if (par(i).cost<Gbest.cost)
        
        Gbest=par(i).best;
        
    end

    end
    
    
end

BestCost(it)=Gbest.cost;
disp(['iter : ' num2str(it) ' BestCost : ' num2str(Gbest.cost)]);
if (Gbest.cost==0)
    break;
end

end
disp(Gbest.pos);
disp(num2str(toc));
figure();
plot(BestCost);

title(' NQ | Chom.ir');





























