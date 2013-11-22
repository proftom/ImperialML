function [rate] = classificationError(confusionMatrices, noClass)
    rate = zeros(noClass, size(confusionMatrices, 2));
    
    for i = 1:size(confusionMatrices, 2)
       fold = confusionMatrices{i};
       for j = 1:noClass
           TP = fold(j,j);
           FP = sum(fold(:,j)) - TP;
           FN = sum(fold(j,:)) - TP;
           TN = sum(sum(fold)) - TP - FP - FN;
           rate(j, i) = 1 - (TP + TN)/(TP + TN + FP + FN);
       end
    end
end