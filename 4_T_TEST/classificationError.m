function [rate] = classificationError(confusionMatrices, noClass)
    rate = zeros(noClass, size(confusionMatrices, 2));
    
    for i = 1:size(confusionMatrices, 2)
       fold = confusionMatrices{i};
       for j = 1:noClass
           n = sum(fold(j, :));
           n_predicted = fold(j, j);
           rate(j, i) = 1 - n_predicted/n;
       end
    end
end