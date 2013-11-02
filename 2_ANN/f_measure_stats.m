function [minimum, maximum, average] = f_measure_stats(recall_precision_rate, alpha)

    f = zeros(1,size(recall_precision_rate,1));

    for i = 1:size(recall_precision_rate)
        f(i) = f_measure(alpha, recall_precision_rate(i,1), recall_precision_rate(i,2));
    end
    
    minimum = min(f,[],2);
    maximum = max(f,[],2);
    average = mean(f,2); 
end

function f = f_measure(alpha, recall, precision)

f = (1+alpha) * (precision .* recall) ./ ...
    (alpha * precision + recall);

end