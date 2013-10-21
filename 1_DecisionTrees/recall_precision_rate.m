% Actual and predicted are expected to be in column vector form
% Possible outcomes is the number of possible classes/outcomes
% Returns a possible_outcomes by 2 matrix
% where the first column is the recall rate, and the second column
% is the precision rate in percentage
function matrix = recall_precision_rate...
    (actual, predicted, possible_outcomes)
    matrix = zeros(possible_outcomes, 2);
    confusion = confusion_matrix(actual, predicted, possible_outcomes);
    
    for outcome = 1:possible_outcomes
        tp = confusion(outcome, outcome);
        fn = sum(confusion(outcome, :)) - tp;
        fp = sum(confusion(:, outcome)) - tp;
        
        matrix(outcome, 1) = tp/(tp + fn) * 100;
        matrix(outcome, 2) = tp/(tp + fp) * 100;
    end

end