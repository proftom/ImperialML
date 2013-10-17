function tree = decision_tree_learning(examples, attributes, binary_targets)

    %All binary_targets are equal
    if all(binary_targets == binary_targets(1))
        tree = make_leaf_node(binary_targets(1));
    elseif (sum(attributes) == 0)
        tree = make_leaf_node(mode(binary_targets));
    else
       %Find the best attribute to branch on
       best_attribute = ml1_chooseBestAttribute(examples, attributes, binary_targets); %marcin
       
       %Create a node
       tree = make_internal_node(best_attribute);
       
       %Create a branch for each attribute (only true or false, so we can
       %explicitally write it)
       for i = 0:1
           
          [examples_i, binary_targets_i] = extract_subset(examples, binary_targets, best_attribute, i);
                    
          if (isempty(examples_i))
             %Vote whether to accept the attribute
            tree.kids{i+1} = make_leaf_node(mode(binary_targets));
          else
            %Remove best_attribute (as it can not appear in a sub tree of
            %itself)
            attributes(best_attribute) = 0;
            tree.kids{i+1} = decision_tree_learning(examples_i, attributes, binary_targets_i);
          end
              
       end
        
    end
    
end

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

function node = make_node(op, class)
    node = struct();
    
    node.op = op;
    node.kids = {};
    node.class = class;
end

function node = make_internal_node(op)
    node = make_node(op, '');
end

function node = make_leaf_node(value)
    node = make_node('', value);
end

%Can reduce randomness by not taking lower mode (0) when there is a tie for
%the classification at the leaf node
function mode = upper_mode(a)
   if (length(a) - sum(a) >= (length(a) / 2)) 
       mode = 1;
   else 
       mode = 0;
   end      
end