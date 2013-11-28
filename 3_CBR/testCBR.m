function [ predictions ] = testCBR(cbr,x2)
    predictions = zeros(size(x2,1),1);
    
    for j=1:size(x2,1)
        newCase = makeCase(x2(j,:),0);
        neighbourCases = retrieve(cbr,newCase);
        solvedCase = reuse(neighbourCases,newCase, cbr);
        cbr = retain(cbr,solvedCase);

        predictions(j) = solvedCase.class;
    end
end