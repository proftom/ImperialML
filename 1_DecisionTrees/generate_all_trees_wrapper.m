function tree = generate_all_trees_wrapper(examples, attributes, allTargets) 

    for i = 1:6
        binary_targets = ml1_transformTargets(i, allTargets);   
        t(i) = decision_tree_learning(examples, attributes, binary_targets);
    end
    
    tree = t';
    
end