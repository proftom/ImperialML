function tree = decision_tree_learning(examples, attributes, binary_targets)

    if all(binary_targets == binary_targets(1))
        %Return a single leaf node
        disp('all the same')
    elseif (isempty(attributes))
        
            disp('empty')
    else        
       %Find the best attribute to branch on
       best_attribute = 0; %marcin
       tree = make_internal_node(best_attribute);
       
       %Create a branch for each attribute
       for i = 1:2
          
          %examples_new =  
          %binary_targets_new = 
          
          if (isempty(examples))
             make_leaf_node 
          end
              
       end
        
    end
    
    
    
end


function node = make_node(op, class)
    node = struct();
    
    node.op = op;
    node.kids = {};
    node.class = class;
end

function node = make_internal_node(op)
    node = make_node(op, '')
end

function node = make_leaf_node(value)
    node = make_node('', value)
end