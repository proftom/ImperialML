function predictions = testANN(net, inputs)

    if size(net) == 1
        % one network with six output
        y = sim(net, inputs);
        predictions = NNout2labels(y);
    else
        % multiple networks with one output

        temp = zeros(length(net),length(inputs));
        for i = 1:length(net)
            temp(i,:) = sim(net{i},inputs);
        end
        predictions = NNout2labels(temp);
    end
    
end