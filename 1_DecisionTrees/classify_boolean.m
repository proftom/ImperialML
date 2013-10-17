% Using a single tree, generate a yes/no answer for items
function y = classify_boolean(tree, x)
    y = nan(size(x, 1), 1);
    for i = 1:size(x, 1)
       y(i) = classify_boolean_single_input(tree, x(i));
    end
end

% Using a SINGLE tree, generate a yes/no answer for a single item
function result = classify_boolean_single_input(tree, x)
    if is_leaf(tree)
        result = tree.class;
    else
        result = classify_boolean_single_input...
            (tree.kids{x(1, tree.op) + 1}, x);
    end
end

function result = is_leaf(node)
    % Will blow up if .op does not exist
    result = isempty(node.op);
end
