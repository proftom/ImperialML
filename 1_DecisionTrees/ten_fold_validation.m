function results = ten_fold_validation(examples, classifications, strategy)

%Optional arguments are not properly implemented in MATLAB... like most
%things
if nargin < 3
    strategy = 1;
end

for i = 1:9
    
    %Reserve some data for testing
    test_examples = examples((i-1)*100 + 1:i*100, :);
    test_classifications = classifications((i-1)*100 + 1:i*100, :);
    
    
    %Data used to train the tree
    training_examples = examples([1 : (i-1)*100 (i)*100 + 1: 1000], :);
    training_classifications = classifications([1 : (i-1)*100 (i)*100 + 1: 1000],:);
    emotion_decision_trees = generate_all_trees_wrapper(training_examples, ones(1,45), training_classifications);
    
    %Concatinate classifications
    classifcation_results((i-1)*100+1:i*100,:) = classify(emotion_decision_trees',  test_examples, strategy);
    
end
    
    %Unfortunately sample size is 1000 +  a little bit more, hence if we
    %wish to include a little bit more, we can not use our analog loop
    %above and must explicitly code for this event. 
    test_examples = examples(901:length(examples), :);
    test_classifications = classifications(901:length(examples), :);
    training_examples = examples(1:900, :);
    training_classifications = classifications(1:900, :);
    emotion_decision_trees = generate_all_trees_wrapper(training_examples, ones(1,45), training_classifications);
    
    %Concatinate results
    classifcation_results(901:length(examples),:) = classify(emotion_decision_trees',  test_examples, strategy);

results = classifcation_results;

%Access an invidual tree by
%all_trees{1}(2)

end