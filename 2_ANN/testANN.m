function predictions = testANN(net, inputs)
    if size(net) == 1
        % one network with six output
        y = sim(net, inputs);
        predictions = NNout2labels(y);
    else
        % six networks, each with one output 
        % TODO
    end
end