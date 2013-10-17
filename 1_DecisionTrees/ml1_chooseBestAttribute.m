function [ bestAttribute, gainsVector ] = ml1_chooseBestAttribute(examples, attributes, binary_targets)

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
             
            % save the information gain for the current attribute in a
            % vector
            gainsVector(i) = informationGain(targetEntropy, targetLength, positiveTarget_AttributeZero, negativeTarget_AttributeZero, positiveTarget_AttributeOne, negativeTarget_AttributeOne);
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
        entropy = - positiveFactor*log2(positiveFactor) - negativeFactor*log2(negativeFactor);
    else
        entropy = 0;
    end
    
end

function [informationGain] = informationGain(targetEntropy, targetLength, positiveAttributeZero, negativeAttributeZero, positiveAttributeOne, negativeAttributeOne)
    
    zeroFactor = (positiveAttributeZero + negativeAttributeZero) / targetLength;
    oneFactor = (positiveAttributeOne + negativeAttributeOne) / targetLength;
    informationGain = targetEntropy - zeroFactor*(entropy(positiveAttributeZero, negativeAttributeZero)) - oneFactor*(entropy(positiveAttributeOne, negativeAttributeOne)); 

end