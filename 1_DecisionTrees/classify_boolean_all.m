function y = classify_boolean_all(all_trees, x)
    y = nan(size(x, 1), size(all_trees, 1));

    for tree_i = 1: size(all_trees, 1)
        tree = all_trees(tree_i);
        for i = 1:size(x, 1)
           y(i, tree_i) = classify_boolean(tree, x(i, :)) 
        end
    end
end