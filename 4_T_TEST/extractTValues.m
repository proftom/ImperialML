function tValues = extractTValues(tMatrix)
    tValues = zeros(size(tMatrix));
    for i = 1:size(tMatrix, 1)
       for j = 1:size(tMatrix,2)
           tValues(i, j) = tMatrix(i, j).tstat;
       end
    end
end