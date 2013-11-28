function distance = calculateDistance(a, b, ig, method)
    if nargin < 4
       method = 1;
    end

    if method == 1
        distance = calculateDistanceManhattan(a, b);
    elseif method == 2
        distance = calculateDistanceEuclidean(a, b);
    elseif method == 3
        distance = calculateDistanceIG(a, b, ig);
    end
end

% ------ MANHATTAN DISTANCE ------

function distance = calculateDistanceManhattan(a, b)
    assert(size(a, 2) == size(b,2));
    distance = sum(abs(a - b));
end

% ------ EUCLIDEAN DISTANCE ------

function distance = calculateDistanceEuclidean(a, b)
    assert(size(a, 2) == size(b,2));
    distance = sum(abs(a - b));
    distance = sqrt(distance);
end

% ------ IG WEIGHTED DISTANCE ------
function distance = calculateDistanceIG(a, b, ig)
    assert(size(a, 2) == size(b,2) && size(a, 2) == size(ig, 2));
    
    distance = 0;
    
    for i = 1:size(a, 2)
       distance = distance + 1/ig(i) * abs(a(i) - b(i)); 
    end
end
