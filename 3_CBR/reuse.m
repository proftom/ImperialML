function newCase = reuse(cases, newCase, cbr)
    % Base case
    if(size(cases, 1) == 1)
        newCase.class = cases(1).class;
        return;
    end

    NO_CLASS = 6; % Number of possible classes
    
    ig = calculateIG(cbr);

    % 1 - Inverse Weighted Distance Voting
    scores = zeros(1, NO_CLASS);
    inverseDistance = zeros(1,size(cases,1));

    for i = 1:size(cases,1)
       inverseDistance(i) = 1/calculateDistance(cases(i).au, newCase.au, ig);
       scores(cases(i).class) = scores(cases(i).class) + inverseDistance(i);
    end
    
    [maxScore1,maxIndex1] = max(scores);
    scores(maxIndex1) = [];
    maxScore2 = max(scores);
    
    if(maxScore1 ~= maxScore2)
        newCase.class = maxIndex1;
        return;
    end
    
    % 2 - Typicality
    scores = zeros(1, NO_CLASS);
    for i = 1:size(cases, 1)
        inverseDistance(i) = inverseDistance(i) * cases(i).typicality;
        scores(cases(i).class) = scores(cases(i).class) + inverseDistance(i);
    end
    
    [maxScore1,maxIndex1] = max(scores);
    scores(maxIndex1) = [];
    maxScore2 = max(scores);
    
    if(maxScore1 ~= maxScore2)
        newCase.class = maxIndex1;
        return;
    end
    
    % 3 - Trim the k-NN to (k-1)-NN if the case is still unresolved
    newCase = reuse(cases(1:size(cases,1)-1),newCase,cbr);
end