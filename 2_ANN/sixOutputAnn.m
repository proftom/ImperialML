% Given x and y transformed into the format required using ANNData
% return an ANN with six outputs trained for a set of 45-attributes inputs
function [net, tr] = sixOutputAnn(x, y, hiddenLayerSize,...
                                  trainingFunction, maxEpochs)
    % Handle optional arguments
    if nargin < 3
       hiddenLayerSize = 10;
    end
    if nargin < 4
        trainingFunction = 'trainscg';
    end
    if nargin < 5
       maxEpochs = 1000; 
    end

    % Create the network
    net = feedforwardnet(hiddenLayerSize, trainingFunction);
    % Train network
    net.trainParam.epochs = maxEpochs;
    [net, tr] = train(net, x, y);
end
