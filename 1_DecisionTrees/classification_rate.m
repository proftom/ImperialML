% Column vectors expected
function rate = classification_rate(actual, predicted)
    assert(size(actual, 1) == size(predicted, 1));
    
    mistakes = size(find(actual - predicted), 1);
    rate = 1 - mistakes/size(actual, 1);
end