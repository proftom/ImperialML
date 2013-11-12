function [kase, distances] = retrieve(cbr, newCase)
    % Parameter to retrieve the k-nearest neighbours
    k = 5;
    
    distances = zeros(2, size(cbr, 1));
    for i = 1: size(cbr, 1)
       distances(i, 1) = i;
       distances(i, 2) = calculateDistance(cbr(i).au, newCase); 
    end
    
    distances = sortrows(distances, 2);
    
    kase = repmat(makeCase([],[]), k, 1 );
    for i = 1:k
       kase(i) = cbr(distances(i, 1)); 
    end
    
    distances = distances(1:k, 2);
end

function distance = calculateDistance(a, b)
    assert(size(a, 2) == size(b,2));
    distance = sum(abs(a - b));
end

