function net = generateSingleOutputNetworks(xANN,yANN,layers,neurons,transferFcn,trainingFcn,lr)

    possibleOutcomes = size(yANN,1);
    hidden = neurons*ones(1,layers);

    net = cell(1,possibleOutcomes);

    for i=1:possibleOutcomes
        temptarget = yANN(i,:);
        tempnet = feedforwardnet(hidden,trainingFcn);
        for j = 1:layers
            tempnet.layers{j}.transferFcn = transferFcn;
        end
        tempnet.trainParam.showWindow = 0;
        tempnet.trainParam.lr = lr;
        tempnet.divideFcn = 'divideind';
        tempnet.divideParam.trainInd = 1:800;
        tempnet.divideParam.valInd = 801:900;
        tempnet.divideParam.testInd = [];
        tempnet = configure(tempnet, xANN, temptarget);
        net{i} = train(tempnet, xANN, temptarget);
    end
end