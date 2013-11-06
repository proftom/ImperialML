function [net] = generateMultiOutputNetwork(xANN,yANN,layers,neurons,transferFcn,trainingFcn,lr) 
    
    hidden = neurons*ones(1,layers);
    net = feedforwardnet(hidden,trainingFcn);
    net = configure(net,xANN,yANN);

    net.trainParam.showWindow = 0;
    for i = 1:layers
        net.layers{i}.transferFcn = transferFcn;
    end
    net.trainParam.lr = lr;
    net.trainParam.showWindow = 0;
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = 1:800;
    net.divideParam.valInd = 801:900;
    net.divideParam.testInd = [];
    
    net = train(net, xANN, yANN);
    
end