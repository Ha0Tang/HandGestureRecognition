% Computes smooth estimates of statistics based on classification output,
% based on either the binormal or the alpha-binormal model.
% 
% Usage:
%     [TPR, FPR, PPV, AUC, AP] = prc_stats_binormal(targs, dvs, alpha_binormal)
% 
% Arguments:
%     targs: a vector of true class labels (targets). The vector must only
%         contain the values -1 (for negative examples) and +1 (for
%         positive examples).
%     dvs: a vector of decision values. The vector must have the same size
%         as 'targs'
%     alpha_binormal: whether to use the alpha-binormal model, in
%         which the class imbalance is estimated from the data (default =
%         false, i.e., classes are assumed to be perfectly balanced).
%         This setting is highly recommended for smooth estimates of the
%         precision-recall curve.
% 
% Return values:
%     TPR: true positive rate (recall)
%     FPR: false positive rate
%     PPV: positive predictive value (precision)
%     AUC: area under the ROC curve
%     AP: area under the PR curve (average precision)
% 
% Literature:
%     K.H. Brodersen, C.S. Ong, K.E. Stephan, J.M. Buhmann (2010). The
%     binormal assumption on precision-recall curves. In: Proceedings of
%     the 20th International Conference on Pattern Recognition (ICPR).

% Kay H. Brodersen & Cheng Soon Ong, ETH Zurich, Switzerland
% $Id: prc_stats_binormal.m 6393 2010-06-14 15:24:46Z bkay $
% -------------------------------------------------------------------------
function [TPR, FPR, PPV, AUC, AP] = prc_stats_binormal(targs, dvs, alpha_binormal)
    
    % Set default values
    try, estimateClassImbalance; catch; estimateClassImbalance = false; end
    
    % Check input
    targs = targs(:)';
    assert(all(targs==-1 | targs==1), 'targs must only contain -1 and 1');
    dvs = dvs(:)';
    assert(length(targs)==length(dvs), 'targs and dvs must have the same number of elements');
    assert(isscalar(alpha_binormal) && ~isstr(alpha_binormal), 'alpha_binormal must be true or false');
    
    % Get class-conditional decision values
    pos = dvs(targs == 1);
    neg = dvs(targs == -1);
    assert(length(pos)>=2 && length(neg)>=2, 'targs must contain at least two examples of either class');
    
    % Estimate mean and std.dev. from the data
    muP = mean(pos);
    muN = mean(neg);
    sigmaP = std(pos);
    sigmaN = std(neg);
    assert(sigmaP>0 & sigmaN>0, 'dvs must allow for estimation of positive class-conditional standard deviations');
    
    % Estimate class balance as well?
    if alpha_binormal
        alpha = length(pos)/length(targs);
        assert(alpha>=0 && alpha<=1);
    else
        alpha = 0.5;
    end
    
    % Compute stats
    [TPR, FPR, PPV, AUC, AP] = prc_stats(alpha, muN, sigmaN, muP, sigmaP);
    
end
