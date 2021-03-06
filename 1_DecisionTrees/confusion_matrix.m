% Take two column vectors, generate the confusion matrix
% Possible outcomes is the number of unique classifications
function matrix = confusion_matrix(actual, predicted, possible_outcomes)
    assert(size(actual, 1) == size(predicted, 1));
    matrix = zeros(possible_outcomes, possible_outcomes);
    
    for i = 1:size(actual, 1)
       matrix(actual(i), predicted(i)) =...
           matrix(actual(i), predicted(i)) + 1;
    end

end
