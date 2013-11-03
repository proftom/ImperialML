% This function performs n fold cross validation, which partitions a data
% set into n parts. n iterations over the dataset are performed, where
% each iteration takes a small partition (total size of data / n) and the
% remaining data (a large partition). A tree is generated from the large
% partition, before testing how well the smaller partition fits to the
% generated tree. This produces total size of data / n results each
% iteration. With each iteration the partitions change.
% Possible outcomes is the number of unique classifications
function confusionMatrix = nFoldValidateMulti(examples, classifications, n)
    % Default to split paritions into 10 
    if nargin < 3
        n = 10;
    end

    confusionMatrix = cell(1,n);
    
    %Length, which forms upper bound
    len = length(examples);
    % Size of each partition
    partition_size = floor(len / n);       

    
    for i = 1:n - 1
    % A little tricky to read to begin with, but we use syntax to select
    % multiple parts of the vector/matrix inline (without having to declare
    % upper and lower portitions of the matrix, and then recombine
    
        % Reserve some data for testing
        testExamples = examples((i-1)*partition_size + 1: ...
            i*partition_size, :);
        testClasses = classifications((i-1)*partition_size + 1:i*partition_size, :);
        [testExamplesANN,~] = ANNdata(testExamples,testClasses);

        % Data used to train the nework
        trainingExamples = examples([1 : (i-1)*partition_size ... 
            (i)*partition_size + 1: len], ...
            :);
        trainingClasses = classifications(...
            [1 : (i-1)*partition_size (i*partition_size) + 1 : len], :);
        [trainingExamplesANN,trainingClassesANN] = ANNdata(trainingExamples,trainingClasses);
        
        net = generateMultiOutputNetwork(trainingExamplesANN,trainingClassesANN,1,20,'tansig','trainscg',0.01);
        predictions = testANN(net, testExamplesANN);
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
        [testExamplesANN,~] = ANNdata(testExamples,testClasses);
        
        % Grab the data to generate the tree
        trainingExamples = examples(1 : (n - 1)*partition_size, :);
        trainingClasses = classifications(1:(n - 1) * partition_size, :);
        [trainingExamplesANN,trainingClassesANN] = ANNdata(trainingExamples,trainingClasses);
        
        net = generateMultiOutputNetwork(trainingExamplesANN,trainingClassesANN,1,20,'tansig','trainscg',0.01);
        predictions = testANN(net, testExamplesANN);
        confusionMatrix{n} = confusion_matrix(testClasses,predictions,6);
end