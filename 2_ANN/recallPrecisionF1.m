function [ recallPrecisionF1 ] = recallPrecisionF1(confusionMatrix)
    possibleOutcomes = size(confusionMatrix,1);
    recallPrecisionF1 = zeros(possibleOutcomes,3);
    
    for outcome = 1:possibleOutcomes
        tp = confusionMatrix(outcome, outcome);
        fn = sum(confusionMatrix(outcome, :)) - tp;
        fp = sum(confusionMatrix(:, outcome)) - tp;
        
        recallPrecisionF1(outcome,1) = tp/(tp + fn);
        recallPrecisionF1(outcome,2) = tp/(tp + fp);
        recallPrecisionF1(outcome,3) = ( 2 * recallPrecisionF1(outcome,1) * recallPrecisionF1(outcome,2) ) / ( recallPrecisionF1(outcome,1) + recallPrecisionF1(outcome,2) );
    end

end