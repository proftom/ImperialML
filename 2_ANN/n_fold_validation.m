% This function performs n fold cross validation, which partitions a data
% set into n parts. n iterations over the dataset are performed, where
% each iteration takes a small partition (total size of data / n) and the
% remaining data (a large partition). A tree is generated from the large
% partition, before testing how well the smaller partition fits to the
% generated tree. This produces total size of data / n results each
% iteration. With each iteration the partitions change.
% Possible outcomes is the number of unique classifications
function results = n_fold_validation(examples, classifications, n)
    % Default to split paritions into 10 
    if nargin < 3
        n = 10;
    end
    
    
    %Length, which forms upper bound
    len = length(examples);
    
    % Size of each partition
    partition_size = floor(len / n);       

    
    for i = 1:n - 1
    % A little tricky to read to begin with, but we use syntax to select
    % multiple parts of the vector/matrix inline (without having to declare
    % upper and lower portitions of the matrix, and then recombine
    
        
        % Reserve some data for testing
        test_examples = examples((i-1)*partition_size + 1: ...
            i*partition_size, :);
        
        test_classifications = classifications((i-1)*partition_size + 1: ...
            i*partition_size, :);
        

        % Data used to train the nework
        training_examples = examples([1 : (i-1)*partition_size ... 
            (i)*partition_size + 1: len], ...
            :);
        
        training_classifications = classifications(...
            [1 : (i-1)*partition_size (i*partition_size) + 1 : len], :);
        
        
        [x2,y2] = ANNdata(training_examples,training_classifications);
        net = multiOutput(x2,y2);
        predictions = testANN(net, test_examples');
        rec = recall_precision_rate(test_classifications,predictions,6);
        results(i) = f_measure_stats(rec,1);
        
    end

        lower_bound = (n - 1)*partition_size;

        % Unfortunately the sample size may not parition perfectly. 
        % While most rookies would use an ugly looking if statement
        % it is preferable to add the final loop iteration (which would 
        % contain the remainder) explicitly. 

        % Set aside the data to exercise the generated tree
        test_examples = examples(lower_bound + 1 : length(examples), :);
        
        test_classifications = examples(lower_bound + 1 : length(examples), :);

        % Grab the data to generate the tree
        training_examples = examples(1 : (n - 1)*partition_size, :);
        
        training_classifications = classifications(1:(n - 1) * ...
            partition_size, :);
        
        [x2,y2] = ANNdata(training_examples,training_classifications);
        net = multiOutput(x2,y2);
        predictions = testANN(net, test_examples');
        rec = recall_precision_rate(test_classifications,predictions,6);
        results(n) = f_measure_stats(rec,1);

end