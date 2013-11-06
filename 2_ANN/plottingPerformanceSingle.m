function [ method ] = plottingPerformanceSingle(x,y)

method = zeros(11,10);

indexGoal = 1;

for i = 0:0.001:0.01
    display(indexGoal);
    indexGrad = 1;
    for j = 1e-6:1e-6:1e-5
        display(indexGrad);
        
        b = optimiseSingle(x,y,1,9,'tansig','trainscg',0.01,i,j);
        method(indexGoal,indexGrad) = method(indexGoal,indexGrad) + (b(1,1) + b(2,2) + b(3,3) + b(4,4) + b(5,5) + b(6,6))/104;
        
        indexGrad = indexGrad + 1;
    end
    indexGoal = indexGoal + 1;
end
end