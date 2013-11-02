% Given x and y transformed into the format required using ANNData
% return an ANN with six outputs trained for a set of 45-attributes inputs
function results = parametricSixOutputANN(x, y)
    
    trainingFunction = 'trainscg';
    results = nan(3, 3, 1);

    % Create the network
    
    
    % Train network

    %net.trainParam.goal
    %net.trainParam.time
    %net.trainParam.min_grad
    %net.trainParam.max_fail
    %net.trainParam.sigma
    %net.trainParam.lambda
    

    
    %Change hidden units
        %for i = 25:50
        for layers = 1:3
          a = unique(combntns(repmat(20:22,1,layers),layers), 'rows');          
            for combinations = 1:size(a,1)
                
                net = feedforwardnet(combinations, trainingFunction);
                net.trainParam.epochs = 200;    
                net.trainParam.showWindow = 0;
                [~, tr] = train(net, x, y);

                results(layers, combinations) = tr.best_vperf;
                %results(layers, combinations, 2) = tr.best_tperf;
                %results(layers, combinations, 3) = tr.best_perf;
            
           end
       end

        %end
    
    return;
    
end
