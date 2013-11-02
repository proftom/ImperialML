function matrix = recall_precision_rate...
    (actual, predicted, possible_outcomes)
    matrix = zeros(possible_outcomes, 2);
    confusion = confusion_matrix(actual, predicted, possible_outcomes);
    
    for outcome = 1:possible_outcomes
        tp = confusion(outcome, outcome);
        fn = sum(confusion(outcome, :)) - tp;
        fp = sum(confusion(:, outcome)) - tp;
        
        matrix(outcome, 1) = tp/(tp + fn);
        matrix(outcome, 2) = tp/(tp + fp);
    end

end