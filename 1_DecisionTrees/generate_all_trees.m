% Generate trees for that emotion from the
% examples given and the targets given
% The number of attributes is inferred from the number of columns in the
% examples provided
% Provide the number of trees to generate
function tree = generate_all_trees(examples, targets, no_trees)
    % Pre-allocate
    tree = repmat(make_node('',''), no_trees, 1);
    for i = 1:no_trees
        tree(i) = generate_tree(examples, targets, i);
    end
end