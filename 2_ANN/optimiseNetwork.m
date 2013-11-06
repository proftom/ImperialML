function [recallPrecision, confusion] = optimiseNetwork(x,y,layers,neurons,transferFcn,trainingFcn,lr,goal,grad) 

    trainingSet = x(1:900,:);
    trainingClass = y(1:900);
    [trainingSetANN, trainingClassANN] = ANNdata(trainingSet,trainingClass);
    
    testSet = x(901:size(x,1),:);
    testClass = y(901:size(x,1));
    [testSetANN, ~] = ANNdata(testSet,testClass);
    
    hidden = neurons*ones(1,layers);
    
    net = feedforwardnet(hidden,trainingFcn);
    net = configure(net,trainingSetANN,trainingClassANN);
    
    for i = 1:layers
        net.layers{i}.transferFcn = transferFcn;
    end
    
    net.trainParam.lr = lr;
    net.trainParam.goal = goal;
    net.trainParam.min_grad = grad;
    net.trainParam.showWindow = 0;
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = 1:800;
    net.divideParam.valInd = 801:900;
    net.divideParam.testInd = [];
    
    net = train(net,trainingSetANN,trainingClassANN);
    predictions = sim(net,testSetANN);
    
    confusion = confusion_matrix(testClass,NNout2labels(predictions),6);
    recallPrecision = recallPrecisionF1(confusion);
end