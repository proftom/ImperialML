function [ allTargets ] = ml1_transformTargets(emotion, allTargets)
    if(emotion > 6 || emotion < 1)
        error('Wrong emotion value');
    end

    for i=1:length(allTargets)
        if(allTargets(i) == emotion)
            allTargets(i) = 1;
        else
            allTargets(i) = 0;
        end
    end
end