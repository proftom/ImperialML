function stats = eval(x, y)
    [x2,y2] = ANNdata(x,y);
    net = singleOutput(x2,y2);
    predictions = testANN(net);
    rec = recall_precision_rate(y,predictions,6);
    stats = f_measure_stats(rec,1);
end
