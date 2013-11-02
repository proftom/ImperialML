function [net] = multiOutput(inputs,targets)
net = feedforwardnet(10,'trainlm');

net.divideParam.trainRatio = 0.7;
net.divideParam.valRatio = 0.3;
net.trainParam.epochs = 100;
net.trainParam.showWindow = 0;
net = configure(net, inputs, targets);
net = train(net, inputs, targets);
end