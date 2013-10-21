% Given examples, along with the corresponding column vector of binary
% targets/classification, build a decision tree.
% Attributes is a row vector of attributes, which consists of 
% zeroes or ones to indicate if an attribute should be used.
% This is a recursive function.
function tree =... 
    decision_tree_learning(examples, attributes, binary_targets)

    % All binary_targets are equal
    if all(binary_targets == binary_targets(1))
        tree = make_leaf_node(binary_targets(1));
    elseif (sum(attributes) == 0)
        tree = make_leaf_node(mode(binary_targets));
    else
       % Find the best attribute to branch on
       best_attribute = choose_best_attribute(examples,...
           attributes, binary_targets);
       
       % Create a node
       tree = make_internal_node(best_attribute);
       
       % Create a branch for each attribute (only true or false, so we can
       % just do a loop for 0 to 1)
       for i = 0:1   
          [examples_i, binary_targets_i] =...
              extract_subset(examples, binary_targets, best_attribute, i);
                    
          if (isempty(examples_i))
             % Decide whether to accept the attribute
            tree.kids{i+1} = make_leaf_node(mode(binary_targets));
          else
            % Remove best_attribute (as it can not appear in a sub tree of
            % itself)
            attributes(best_attribute) = 0;
            tree.kids{i+1} =...
                decision_tree_learning(examples_i, attributes, binary_targets_i);
          end
       end
    end   
end

%%%%%%%%%%%%%%%%%%% Internal Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ bestAttribute, gainsVector ] =...
    choose_best_attribute(examples, attributes, binary_targets)

    % calculate entropy of the target set
    targetLength = length(binary_targets);
    targetPositive = sum(binary_targets);
    targetNegative = targetLength - targetPositive;

    targetEntropy = entropy(targetPositive, targetNegative);

    % calculate information gain of all attributes which we are still
    % concerned with
    gainsVector = zeros(1,length(attributes));
    for i=1:length(attributes)
        if(attributes(i) == 0) % if this attribute has already been used
            gainsVector(i) = -1;
        else
            % calculate information gain for the unused attribute

            positiveTarget_AttributeZero = 0;
            positiveTarget_AttributeOne = 0;
            negativeTarget_AttributeZero = 0;
            negativeTarget_AttributeOne = 0;

            % count positive and negative targets for each attribute value
            % (binary in this case)
            for j=1:length(binary_targets)
                if(examples(j,i) == 0 && binary_targets(j) == 0)
                    negativeTarget_AttributeZero =...
                        negativeTarget_AttributeZero + 1;
                end
                if(examples(j,i) == 0 && binary_targets(j) == 1)
                    positiveTarget_AttributeZero =...
                        positiveTarget_AttributeZero + 1;
                end
                if(examples(j,i) == 1 && binary_targets(j) == 0)
                    negativeTarget_AttributeOne =...
                        negativeTarget_AttributeOne + 1;
                end
                if(examples(j,i) == 1 && binary_targets(j) == 1)
                    positiveTarget_AttributeOne =...
                        positiveTarget_AttributeOne + 1;
                end
            end
             
            % save the information gain for the current attribute in a
            % vector
            gainsVector(i) =...
                informationGain(targetEntropy, targetLength,...
                                positiveTarget_AttributeZero,...
                                negativeTarget_AttributeZero,...
                                positiveTarget_AttributeOne,...
                                negativeTarget_AttributeOne);
        end
    end
    
    % extract the attribute index for which the information gain has the
    % biggest value
    [~,bestAttribute] = max(gainsVector);
end

function [entropy] = entropy(positive, negative)
    if(positive > 0 && negative > 0)
        positiveFactor = positive/(positive + negative);
        negativeFactor = negative/(positive + negative);
        entropy = - positiveFactor*log2(positiveFactor)...
            - negativeFactor*log2(negativeFactor);
    else
        entropy = 0;
    end
    
end

function [informationGain] =...
    informationGain(targetEntropy, targetLength, positiveAttributeZero,...
                    negativeAttributeZero, positiveAttributeOne,...
                    negativeAttributeOne)
    
    zeroFactor =...
        (positiveAttributeZero + negativeAttributeZero) / targetLength;
    oneFactor =...
        (positiveAttributeOne + negativeAttributeOne) / targetLength;
    informationGain = targetEntropy -...
        zeroFactor*(entropy(positiveAttributeZero, negativeAttributeZero))...
        - oneFactor*(entropy(positiveAttributeOne, negativeAttributeOne)); 

end

% Based on the best_attribute and the value provided, extract 
% a subset of examples, along with the corresponding binary targets of
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

% Node making helper methods
function node = make_internal_node(op)
    node = make_node(op, '');
end

function node = make_leaf_node(value)
    node = make_node('', value);
end
