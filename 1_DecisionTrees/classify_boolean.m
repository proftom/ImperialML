% Using all trees, generate a matrix with the yes/no decision
% for all the trees
% Also returns depth
function [y, depth] = classify_boolean(all_trees, x)
    y = nan(size(x, 1), size(all_trees, 1));
    depth = nan(size(x, 1), size(all_trees, 1));
    
    for tree_i = 1: size(all_trees, 1)
        tree = all_trees(tree_i);
        [y(:, tree_i), depth(:, tree_i)]...
            = classify_boolean_single_tree(tree, x);
    end
end

% Using a single tree, generate a yes/no answer for items
function [y, depth] = classify_boolean_single_tree(tree, x)
    y = nan(size(x, 1), 1);
    depth = nan(size(x, 1), 1);
    for i = 1:size(x, 1)
       [y(i), depth(i)] = classify_boolean_single_input(tree, x(i, :), 0);
    end
end

% Using a SINGLE tree, generate a yes/no answer for a single item
function [result, depth] = classify_boolean_single_input(tree, x, depth)
    if is_leaf(tree)
        result = tree.class;
    else
        depth = depth + 1;
        [result, depth] = classify_boolean_single_input...
            (tree.kids{x(1, tree.op) + 1}, x, depth);
    end
end

function result = is_leaf(node)
    % Will blow up if .op does not exist
    result = isempty(node.op);
end
