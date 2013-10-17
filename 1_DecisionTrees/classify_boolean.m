% Using a SINGLE tree, generate a yes/no answer
function result = classify_boolean(tree, x)
    if is_leaf(tree)
        result = tree.class;
    else
        result = classify(tree.kids{x(0, tree.op)}, x);
    end
end

function result = is_leaf(node)
    result = exist('node.op') == 0 || node.op == '';
end
