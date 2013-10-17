% Based on the best_attribute and the value provided, extract 
% a subset of examples, along with the corresponding binary target
% the examples that match the attribute value
function [examples_i, binary_targets_i] = ...
    extract_subset(examples, binary_targets, best_attribute,  value)

    % Pre-allocate
    examples_i = nan(size(examples));
    binary_targets_i = nan(size(examples, 1), 1);
    j = 1;

    for i = 1:size(examples, 1)
       if examples(i, best_attribute) == value
           examples_i(j, :) = examples(i, :);
           binary_targets_i(j, :) = binary_targets(i, :);
           j = j + 1;
       end
    end

    % Shrink
    examples_i = examples_i(1:j-1, :);
    binary_targets_i = binary_targets_i(1:j-1, :);
end