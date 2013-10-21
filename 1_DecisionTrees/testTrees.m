% Given a column vector of trees, and examples x, generate
% a column vector of predictions
% This is just a convenience function for the classify function
function predictions = testTrees(trees, x)
    predictions = classify(trees, x, 3);
end