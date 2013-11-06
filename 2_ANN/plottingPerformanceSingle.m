function [ method ] = plottingPerformanceSingle(x,y,trainFcn,layers)

method = zeros(50,1);

for i = 6:50
    for j = 1:5
    b = optimiseSingle(x,y,layers,i,'tansig',trainFcn,0.01);
    method(i) = method(i) + (b(1,1) + b(2,2) + b(3,3) + b(4,4) + b(5,5) + b(6,6))/104;
    end
end
    method = method ./ 5;
end
