function plotAverageF1Measure(confusionMatrixSingle, confusionMatrixMulti)

    foldsSingle = size(confusionMatrixSingle,2);
    foldsMulti = size(confusionMatrixMulti,2);
    
    if(foldsSingle ~= foldsMulti)
        error('plotAvgMeasure:wrongDimensions', 'Number of folds in matrices not equal');
    end

    averageF1Single = zeros(1,foldsSingle);
    averageF1Multi = zeros(1,foldsMulti);
    
    for i=1:foldsSingle
        statsSingle = recallPrecisionF1(confusionMatrixSingle{i});
        statsMulti = recallPrecisionF1(confusionMatrixMulti{i});
        averageF1Single(i) = mean(statsSingle(:,3));
        averageF1Multi(i) = mean(statsMulti(:,3));
    end
    
    plot(1:10,averageF1Single,'b'); hold on;
    plot(1:10,averageF1Multi,'r');
    title('Average F1 measure for each fold');
    xlabel('Fold number');
    ylabel('F1 measure');
    legend('Six single-output networks','One multi-output network');
    scatter(1:10,averageF1Single,35,'b','fill');
    scatter(1:10,averageF1Multi,35,'r','fill');
end