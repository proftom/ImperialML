function distance = calculateDistance(a, b)
    assert(size(a, 2) == size(b,2));
    distance = sum(abs(a - b));
end
