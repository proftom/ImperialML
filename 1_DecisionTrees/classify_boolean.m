% Using a SINGLE tree, generate a yes/no answer
function result = classify_boolean(tree, x)
    if is_leaf(tree)
        result = tree.class;
    else
        result = classify_boolean(tree.kids{x(1, tree.op) + 1}, x);
    end
end

function result = is_leaf(node)
    % Will blow up if .op does not exist
    result = isempty(node.op);
end
