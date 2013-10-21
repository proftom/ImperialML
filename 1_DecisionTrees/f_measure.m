function f = f_measure(alpha, precision, recall)

    f = (1+alpha) * (precision .* recall) ./ ...
            (alpha * precision + recall);

end