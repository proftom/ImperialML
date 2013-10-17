function tree = generate_tree_wrapper(examples, attributes, allTargets, emotion) 

    binary_targets = ml1_transformTargets(emotion, allTargets);   
    tree = decision_tree_learning(examples, attributes, binary_targets);
    
end