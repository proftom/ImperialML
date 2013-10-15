function node = MakeNode(op, class)
    node = struct();
    
    node.op = op;
    node.kids = {};
    node.class = class;
end