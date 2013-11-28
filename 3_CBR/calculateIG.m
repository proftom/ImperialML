function ig = calculateIG(cbr)
    NO_EMOTIONS = 6;
    NO_AU = 45;
    
    ig = zeros(1, NO_AU);

    % Calculate set Entropy E(S)
    targetCount = zeros(1, NO_EMOTIONS);
    
    for i = 1:size(cbr, 1)
        targetCount(1, cbr(i).class) = targetCount(1, cbr(i).class) +...
            cbr(i).typicality;
    end
    
    totalExamples = sum(targetCount);
    setEntropy = entropy(targetCount);
    
    for au = 1:NO_AU
        % auCount is a 2 x NO_EMOTIONS matrix where the columns are
        % the number of cases for each emotion where the AU is true/false
        auCount = zeros(2, NO_EMOTIONS);
        for i = 1:size(cbr, 1)
            class = cbr(i).class;
            auValue = cbr(i).au(au);
            
            auCount(auValue + 1, class) = auCount(auValue + 1, class) +...
                cbr(i).typicality;
        end
        negativeAuEntropy = entropy(auCount(1, :));
        positiveAuEntropy = entropy(auCount(2, :));
        
        ig(au) = setEntropy -...
            sum(auCount(1, :))/totalExamples * negativeAuEntropy -...
            sum(auCount(2, :))/totalExamples * positiveAuEntropy;
    end
end

% Row vector expected of the number of each vector
function [entropy] = entropy(vectors)
    entropy = 0;
    if(all(vectors))
        total = sum(vectors);
        for i = 1:size(vectors, 2)
            probability = vectors(1, i)/total;
            entropy = entropy - probability * log2(probability);
        end
    end
end