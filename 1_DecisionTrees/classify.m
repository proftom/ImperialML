function y = classify(all_trees, x)
    y = nan(size(x, 1), 1);
    boolean = classify_boolean(all_trees, x);
    assert(size(x, 1) == size(boolean, 1), 'Number of inputs != outputs!');
    
    for i = 1:size(boolean, 1)
        y(i) = break_tie(boolean(i, :));
    end
end

% x should be a row vector
function result = break_tie(x)
    if sum(x) == 0
       % No one has decided on a true
       result = randi(size(x, 2));
       %result = 0;
    elseif sum(x) > 1
       % More than one has decided on a true
       indices = find(x);
       random = randi(size(indices, 2));
       result = indices(random);
    else
        [result] = find(x, 1);
    end
end
