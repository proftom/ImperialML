% 
function results = n_fold_validation(examples, classifications, n,strategy)
    % Optional arguments are not properly implemented in MATLAB... like most
    % things

    % Default to split paritions into 10 
    if nargin < 3
        n = 10;
    end

    % Default to apply greatest depth strategy
    if nargin < 4
        strategy = 3;
    end
    
    %Length, which forms upper bound
    len = length(examples);
    
    % Size of each partition
    partition_size = floor(len / n);       

    for i = 1:n - 1

        % Reserve some data for testing
        test_examples = examples((i-1)*partition_size + 1: ...
            i*partition_size, :);


        % Data used to train the tree
        training_examples = examples([1 : (i-1)*partition_size ... 
            (i)*partition_size + 1: len], ...
            :);
        
        training_classifications = classifications(...
            [1 : (i-1)*partition_size (i)*partition_size + 1 : len],:);
        
        emotion_decision_trees = generate_all_trees_wrapper( ... 
            training_examples, ones(1,45), training_classifications);

        % Concatinate the classifications
        classifcation_results((i-1)*partition_size+1:i*partition_size,:)...
            = classify(emotion_decision_trees,  test_examples, strategy);

    end

        lower_bound = (n - 1)*partition_size;

        % Unfortunately the sample size may not parition perfectly. 
        % While most rookies would use an ugly looking if statement
        % it is preferable to add the final loop iteration (which would 
        % contain the remainder) explicitly. 

        % Set aside the data to exercise the generated tree
        test_examples = examples(lower_bound+1:length(examples), :);

        % Grab the data to generate the tree
        training_examples = examples(1:(n - 1)*partition_size, :);
        
        training_classifications = classifications(1:(n - 1) * ...
            partition_size, :);
        
        emotion_decision_trees = 
            generate_all_trees_wrapper(training_examples, ones(1,45), ...
            training_classifications);

        %Concatinate the classifications
        classifcation_results(((n - 1)*partition_size+1) : len,:) =... 
            classify(emotion_decision_trees,  test_examples, strategy);

    results = classifcation_results;

    %Access an invidual tree by
    %all_trees{1}(2)

end