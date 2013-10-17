function results = ten_fold_validation(examples, classifications)

for i = 1:9
    %Reserve some data for testing
    test_examples = examples((i-1)*100 + 1:i*100, :);
    test_classifications = classifications((i-1)*100 + 1:i*100, :);
    training_examples = examples([1 : (i-1)*100 (i)*100 + 1: 1000], :);
    training_classifications = classifications([1 : (i-1)*100 (i)*100 + 1: 1000],:);
    emotion_decision_trees = generate_all_trees_wrapper(training_examples, ones(1,45), training_classifications);
    
    test_results((i-1)*100+1:i*100,:) = classify_boolean(emotion_decision_trees',  test_examples);
    
end

    test_examples = examples(901:1004, :);
    test_classifications = classifications(901:1004, :);
    training_examples = examples(1:900, :);
    training_classifications = classifications(1:900, :);
    emotion_decision_trees = generate_all_trees_wrapper(training_examples, ones(1,45), training_classifications);
    
    test_results(901:1004,:) = classify_boolean(emotion_decision_trees',  test_examples);

results = test_results;

%Access an invidual tree by
%all_trees{1}(2)

end