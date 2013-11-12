function [ confusionMatrix ] = nFoldValidate(examples, classifications, n) 

    % Preallocate for speed
    confusionMatrix = cell(1,n);
    
    %Length, which forms upper bound
    len = length(examples);
    % Size of each partition
    partition_size = floor(len / n);

    for i = 1:(n-1)
    % A little tricky to read to begin with, but we use syntax to select
    % multiple parts of the vector/matrix inline (without having to declare
    % upper and lower portitions of the matrix, and then recombine
    
        % Reserve some data for testing
        testExamples = examples((i-1)*partition_size + 1: ...
            i*partition_size, :);
        testClasses = classifications((i-1)*partition_size + 1:i*partition_size, :);


        % Data used to train the nework
        trainingExamples = examples([1 : (i-1)*partition_size ... 
            (i)*partition_size + 1: len], ...
            :);
        trainingClasses = classifications(...
            [1 : (i-1)*partition_size (i*partition_size) + 1 : len], :);
        
        cbr = CBRInit(trainingExamples, trainingClasses);
        predictions = testCBR(cbr,testExamples);
        confusionMatrix{i} = confusion_matrix(testClasses,predictions,6);
    end
    
    lower_bound = (n - 1)*partition_size;
    
    % Unfortunately the sample size may not parition perfectly.
    % While most rookies would use an ugly looking if statement
    % it is preferable to add the final loop iteration (which would
    % contain the remainder) explicitly.
    
    % Set aside the data to exercise the generated tree
    testExamples = examples(lower_bound + 1 : length(examples), :);
    testClasses = classifications(lower_bound + 1 : length(classifications), :);
    
    % Grab the data to generate the tree
    trainingExamples = examples(1 : (n - 1)*partition_size, :);
    trainingClasses = classifications(1:(n - 1) * partition_size, :);
    
    cbr = CBRInit(trainingExamples, trainingClasses);
    predictions = testCBR(cbr,testExamples);
    confusionMatrix{n} = confusion_matrix(testClasses,predictions,6);

end