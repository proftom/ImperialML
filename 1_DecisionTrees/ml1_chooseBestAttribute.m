function [ bestAttribute, gainsVector ] = ml1_chooseBestAttribute(examples, attributes, binary_targets)

    % calculate entropy of the target set
    targetLength = length(binary_targets);
    targetPositive = sum(binary_targets);
    targetNegative = targetLength - targetPositive;

    if(targetPositive > 0 && targetNegative > 0)
        targetEntropy = -(targetPositive/targetLength)*log2(targetPositive/targetLength) ...
                        -(targetNegative/targetLength)*log2(targetNegative/targetLength);
    else
        targetEntropy = 0;
    end

    % calculate information gain of all attributes which we are still
    % concerned with
    gainsVector = zeros(1,length(attributes));
    for i=1:length(attributes)
        if(attributes(i) == 0) % if this attribute has already been used
            gainsVector(i) = -1;
        else
            % calculate information gain for the unused attribute
            oneAttribute = sum(examples(:,i));
            zeroAttribute = length(examples(:,i)) - oneAttribute;

            positiveTarget_AttributeZero = 0;
            positiveTarget_AttributeOne = 0;
            negativeTarget_AttributeZero = 0;
            negativeTarget_AttributeOne = 0;

            % count positive and negative targets for each attribute value
            % (binary in this case)
            for j=1:length(binary_targets)
                if(examples(j,i) == 0 && binary_targets(j) == 0)
                    negativeTarget_AttributeZero = negativeTarget_AttributeZero + 1;
                end
                if(examples(j,i) == 0 && binary_targets(j) == 1)
                    positiveTarget_AttributeZero = positiveTarget_AttributeZero + 1;
                end
                if(examples(j,i) == 1 && binary_targets(j) == 0)
                    negativeTarget_AttributeOne = negativeTarget_AttributeOne + 1;
                end
                if(examples(j,i) == 1 && binary_targets(j) == 1)
                    positiveTarget_AttributeOne = positiveTarget_AttributeOne + 1;
                end
            end
            
            % calculate the entropy of the targets when the attribute has a
            % value of 0
            if(positiveTarget_AttributeZero > 0 && negativeTarget_AttributeZero > 0)
                negativeEntropy = -(positiveTarget_AttributeZero/zeroAttribute)*log2(positiveTarget_AttributeZero/zeroAttribute) - ...
                (negativeTarget_AttributeZero/zeroAttribute)*log2(negativeTarget_AttributeZero/zeroAttribute);
            else
                negativeEntropy = 0;
            end
            
            % calculate the entropy of the targets when the attribute has a
            % value of 1
            if(positiveTarget_AttributeOne > 0 && negativeTarget_AttributeOne > 0)
                positiveEntropy = -(positiveTarget_AttributeOne/oneAttribute)*log2(positiveTarget_AttributeOne/oneAttribute) - ...
                (negativeTarget_AttributeOne/oneAttribute)*log2(negativeTarget_AttributeOne/oneAttribute);
            else
                positiveEntropy = 0;
            end
            
            % save the information gain for the current attribute in a
            % vector
            gainsVector(i) = targetEntropy - (oneAttribute/targetLength)*positiveEntropy - (zeroAttribute/targetLength)*negativeEntropy;
        end
    end
    
    % extract the attribute index for which the information gain has the
    % biggest value
    [~,bestAttribute] = max(gainsVector);
end