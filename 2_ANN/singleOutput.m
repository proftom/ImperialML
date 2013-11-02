function net = singleOutput(inputs,targets)

for i=1:6
    temptarget = targets(i,:);
    tempnet = feedforwardnet([10,10],'trainlm');
    tempnet.divideParam.trainRatio = 0.7;
    tempnet.divideParam.valRatio = 0.3;
    %tempnet.trainParam.showWindow = 0;
    tempnet = configure(tempnet, inputs, temptarget);
    net(i).tempnet = train(tempnet, inputs, temptarget);
end

end