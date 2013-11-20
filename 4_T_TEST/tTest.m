% Given the three different n-fold confusion matrices for all the 
% three algorithms, return a 6 x 3 matrix for the t-test 
% result vector [h,p,ci,stats] where the columns are
% dt/ann dt/cbr ann/cbr
function tMatrix = tTest(decisionTree, ann, cbr)
    noClass = 6;
    
    tMatrix = repmat(makeEmpty(), noClass, 3);
    
    dt = classificationError(decisionTree, noClass);
    ann = classificationError(ann, noClass);
    cbr = classificationError(cbr, noClass);
    
    % dt/ann
    for i = 1:6
       [h,p,ci,stats] = ttest(dt(i, :), ann(i, :));
       tMatrix(i, 1) = makeNode(h, p, ci, stats);
    end
    
    % dt/cbr
    for i = 1:6
       [h,p,ci,stats] = ttest(dt(i, :), cbr(i, :));
       tMatrix(i, 2) = makeNode(h, p, ci, stats);
    end
    
    % ann/cbr
    for i = 1:6
       [h,p,ci,stats] = ttest(ann(i, :), cbr(i, :));
       tMatrix(i, 3) = makeNode(h, p, ci, stats);
    end
end

function emptyNode = makeEmpty()
    stats = struct;
    stats.tstat = '';
    stats.df = '';
    stats.sd = '';
    
    emptyNode = makeNode('', '', '', stats);
end

function node = makeNode(h, p, ci, stats)
    node = struct;
    node.h = h;
    node.p = p;
    node.ci = ci;
    node.tstat = stats.tstat;
    node.df = stats.df;
    node.sd = stats.sd;
end