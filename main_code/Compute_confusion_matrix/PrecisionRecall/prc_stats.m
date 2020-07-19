% Computes several quantities based on the model-based confusion matrix of
% a classifier. The model specification could be the ground truth or an
% estimate of it.
% 
% Usage:
%     [TPR, FPR, PPV, AUC, AP] = prc_compute_stats(alpha, muN, sigmaN, muP, sigmaP)
%
% Arguments:
%     alpha: fraction of examples from positive class (0 < alpha < 1)
%     muN: mean of decision values from negative class
%     sigmaN: std.dev. of decision values from negative class (must be > 0)
%     muP: mean of decision values from positive class
%     sigmaP: std.dev. of decision values from positive class  (must be > 0)
%     nPoints (optional): number of thresholds to consider (default: 1000)
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
% $Id: prc_stats.m 6393 2010-06-14 15:24:46Z bkay $
% -------------------------------------------------------------------------
function [TPR, FPR, PPV, AUC, AP] = prc_stats(alpha, muN, sigmaN, muP, sigmaP, nPoints)
    
    % Set interpolation accuracy: the higher the more accurate
    try; nPoints; catch; nPoints = 1000; end
    
    % Check input
    assert(isscalar(alpha) && isscalar(muN) && isscalar(sigmaN) && isscalar(muP) && isscalar(sigmaP) && isscalar(nPoints));
    assert(0<alpha && alpha<1, 'class balance ''alpha'' must be strictly between 0 and 1');
    assert(sigmaN>0 && sigmaP>0, 'variances must be positive');
    assert(nPoints>1, 'must use at least 2 interpolation points (nPoints)');
    if nPoints<10, warning('nPoints is very small and may result in highly inaccurate estimates'); end
    
    % Set thresholds between data points
    thr = linspace(muN-5*sigmaN, muP+5*sigmaP, nPoints);
    assert(length(thr)>1);
    
    % Compute parametric confusion matrix
    TP = alpha.*(1-normcdf(thr,muP,sigmaP));
    FP = (1-alpha).*(1-normcdf(thr,muN,sigmaN));
    FN = alpha.*normcdf(thr,muP,sigmaP);
    TN = (1-alpha).*normcdf(thr,muN,sigmaN);
    
    % Compute rates
    TPR = TP./(TP+FN);
    FPR = FP./(FP+TN);
    PPV = TP./(TP+FP);
    
    % Area under the ROC curve
    A = (muP-muN)/sigmaP; B = sigmaN/sigmaP;
    AUC = normcdf(A/sqrt(1+B^2));
    
    % Area under the PR curve
    AP = abs(trapz(TPR,PPV));
end
