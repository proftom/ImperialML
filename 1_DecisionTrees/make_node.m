% Make a node in the decision tree
function node = make_node(op, class)
    node = struct();
    
    node.op = op;
    node.kids = {};
    node.class = class;
end