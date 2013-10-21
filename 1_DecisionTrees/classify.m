% Using a column vector of trees, and examples x, 
% classify the examples according to the tree. 
% Returns a column vector with the classification/targets.
% The strategy used to break ties are as follow:
%   Tie-breaking algorithms
%   1 - (default) pure randomness
%   2 - Minimum depth
%   3 - Maximum depth
% Internally, this function calls classify_boolean to generate binary
% classifications first before breaking the tie
function y = classify(all_trees, x, strategy)
    if nargin < 3
        strategy = 1;
    end
    y = nan(size(x, 1), 1);
    [boolean, depth] = classify_boolean(all_trees, x);
    assert(size(x, 1) == size(boolean, 1) &&...
        size(x, 1) == size(depth, 1) , 'Number of inputs != outputs!');
    
    for i = 1:size(boolean, 1)
        y(i) = break_tie(boolean(i, :), depth(i, :), strategy);
    end
end

% Internal function to break tie.
% x is a row vector for the current tie that needs breaking
function result = break_tie(x, depth, strategy)
    total = sum(x);
    switch strategy
        case 1
            if total == 0
               % No one has decided on a true
               result = randi(size(x, 2));
            elseif total > 1
               % More than one has decided on a true
               indices = find(x);
               random = randi(size(indices, 2));
               result = indices(random);
            else
                [result] = find(x, 1);
            end
        case 2
            if total ~= 1
                % Note: min will always return the index of the first
                % min value it finds
                [~, result] = min(depth);
            else
                [result] = find(x, 1);
            end
        case 3
            if total ~= 1
                % Note: max will always return the index of the first
                % max value it finds
                [~, result] = max(depth);
            else
                [result] = find(x, 1);
            end
    end
end
