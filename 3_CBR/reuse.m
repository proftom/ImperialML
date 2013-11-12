function solvedCase = reuse(cases, newCase)
    % Base case
    if size(cases, 1)
       solvedCase = newCase;
       solvedCase.class = cases(1).class;
       return;
    end
    
    NO_CLASS = 6; % Number of possible classes
    
    % 1- Inverse Weighted Distance Voting
    scores = zeros(1, NO_CLASS);
    
    % Calculate the inverse scores
    for i = 1:size(cases, 1)
       inverseDistance = 1/calculateDistance(cases(i).au, newCase.au);
       scores(cases(i).class) = scores(cases(i).class) + inverseDistance;
    end
    
    % 2- Typicality
    
    
end