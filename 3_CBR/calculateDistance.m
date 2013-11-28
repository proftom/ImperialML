function distance = calculateDistance(a, b, method)
    if nargin < 3
       method = 1;
    end

    if method == 1
        distance = calculateDistanceManhattan(a, b);
    else
        distance = calculateDistanceEuclidean(a, b);
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

% ------ THIRD DISTANCE ------