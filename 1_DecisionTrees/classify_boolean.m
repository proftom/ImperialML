% Using a column vector of trees, generate a matrix
% with each column corresponding to a tree
% and each row corresponding to an example, and each cell
% is a boolean value of whether the particular tree classifies that
% example positively, or negatively
% Also returns a matrix with the same structure, except each cell is the
% depth of the tree at which the classification was derived
function [y, depth] = classify_boolean(all_trees, x)
    % Initialise the data structures to return
    y = nan(size(x, 1), size(all_trees, 1));
    depth = nan(size(x, 1), size(all_trees, 1));
    
    for tree_i = 1: size(all_trees, 1)
        tree = all_trees(tree_i);
        [y(:, tree_i), depth(:, tree_i)]...
            = classify_boolean_single_tree(tree, x);
    end
end

%%%%%%%%%%%%%%%% Internal Helper Functions %%%%%%%%%%%%%%%

% Using a single tree, generate a yes/no answer for items
function [y, depth] = classify_boolean_single_tree(tree, x)
    y = nan(size(x, 1), 1);
    depth = nan(size(x, 1), 1);
    for i = 1:size(x, 1)
       [y(i), depth(i)] = classify_boolean_single_input(tree, x(i, :), 0);
    end
end

% Using a SINGLE tree, generate a yes/no answer for a single item
% This is a recursive function
function [result, depth] = classify_boolean_single_input(tree, x, depth)
    if is_leaf(tree)
        result = tree.class;
    else
        depth = depth + 1;
        [result, depth] = classify_boolean_single_input...
            (tree.kids{x(1, tree.op) + 1}, x, depth);
    end
end

% Returns a boolean value to see if a node is a leaf
function result = is_leaf(node)
    % Will blow up if .op does not exist
    result = isempty(node.op);
end
