% Using all trees, generate a matrix with the yes/no decision
% for all the trees
function y = classify_boolean_all(all_trees, x)
    y = nan(size(x, 1), size(all_trees, 1));

    for tree_i = 1: size(all_trees, 1)
        tree = all_trees(tree_i);
        y(:, tree_i) = classify_boolean(tree, x);
    end
end