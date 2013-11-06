function [confusion] = optimiseSingle(x,y,layers,neurons,transferFcn,trainingFcn,lr,goal,grad) 


trainingSet = x(1:900,:);
trainingClass = y(1:900);
[trainingSetANN, trainingClassANN] = ANNdata(trainingSet,trainingClass);

testSet = x(901:size(x,1),:);
testClass = y(901:size(x,1));
[testSetANN, ~] = ANNdata(testSet,testClass);

possibleOutcomes = size(trainingClassANN,1);
hidden = neurons*ones(1,layers);

net = cell(1,possibleOutcomes);

for i=1:possibleOutcomes
    temptarget = trainingClassANN(i,:);
    tempnet = feedforwardnet(hidden,trainingFcn);
    for j = 1:layers
        tempnet.layers{j}.transferFcn = transferFcn;
    end
    tempnet.trainParam.showWindow = 0;
    tempnet.trainParam.lr = lr;
    tempnet.trainParam.goal = goal;
    tempnet.trainParam.min_grad = grad;
    tempnet.divideFcn = 'divideind';
    tempnet.divideParam.trainInd = 1:800;
    tempnet.divideParam.valInd = 801:900;
    tempnet.divideParam.testInd = [];
    tempnet = configure(tempnet, trainingSetANN, temptarget);
    net{i} = train(tempnet, trainingSetANN, temptarget);
end

temp = zeros(length(net),length(testSetANN));
for i = 1:length(net)
    temp(i,:) = sim(net{i},testSetANN);
end
predictions = NNout2labels(temp);
confusion = confusion_matrix(testClass, predictions, 6);

end
