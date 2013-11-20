% ------ MANHATTAN DISTANCE ------

function distance = calculateDistance(a, b)
    assert(size(a, 2) == size(b,2));
    distance = sum(abs(a - b));
end

% ------ EUCLIDEAN DISTANCE ------

%function distance = calculateDistance(a, b)
%    assert(size(a, 2) == size(b,2));
%    distance = sum(abs(a - b));
%    distance = sqrt(distance);
%end

% ------ THIRD DISTANCE ------