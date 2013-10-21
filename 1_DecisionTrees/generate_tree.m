% For a particular emotion, generate the tree for that emotion from the
% examples given and the targets given
% The number of attributes is inferred from the number of columns in the
% examples provided
function tree = generate_tree(examples, targets, emotion) 
    attributes = ones(1, size(examples, 2));
    binary_targets = transform_targets(emotion, targets);   
    tree = decision_tree_learning(examples, attributes, binary_targets);
end