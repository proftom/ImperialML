function stats = evalstats(x, y)
    [x2,y2] = ANNdata(x,y);
    net = multiOutput(x2,y2);
    predictions = testANN(net, x2);
    rec = recall_precision_rate(y,predictions,6);
    stats = f_measure_stats(rec,1);
end
