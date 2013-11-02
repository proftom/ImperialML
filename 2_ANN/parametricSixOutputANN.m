% Given x and y transformed into the format required using ANNData
% return an ANN with six outputs trained for a set of 45-attributes inputs
function classifcation_results = parametricSixOutputANN(x, y)
    
    trainingFunction = 'trainscg';

    % Create the network
    
    
    % Train network

    %net.trainParam.goal
    %net.trainParam.time
    %net.trainParam.min_grad
    %net.trainParam.max_fail
    %net.trainParam.sigma
    %net.trainParam.lambda
    

    
    %Change hidden units
        for i = 30:50
            for j = 1:3
                a = i*ones(1,j);
                net = feedforwardnet(a, trainingFunction);
                net.trainParam.epochs = 200;    
                net.trainParam.showWindow = 0;    
                %net.trainParam.showCommandLine = 1;
                [~, tr] = train(net, x, y);

                classifcation_results(j, i-29, 1) = tr.best_vperf;
                classifcation_results(j, i-29, 2) = tr.best_tperf;
                classifcation_results(j, i-29, 3) = tr.best_perf;
            end
        end
    
    return;
    
end
