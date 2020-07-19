% Computes empirical statistics based on classification output.
% 
% Usage:
%     [TPR, FPR, PPV, AUC, AP] = prc_stats_empirical(targs, dvs)
% 
% Arguments:
%     targs: true class labels (targets)
%     dvs: decision values output by the classifier
% 
% Return values:
%     TPR: true positive rate (recall)
%     FPR: false positive rate
%     PPV: positive predictive value (precision)
%     AUC: area under the ROC curve
%     AP: area under the PR curve (average precision)
% 
%     Each of these return vectors has length(desireds)+1 elements.
% 
% Literature:
%     K.H. Brodersen, C.S. Ong, K.E. Stephan, J.M. Buhmann (2010). The
%     binormal assumption on precision-recall curves. In: Proceedings of
%     the 20th International Conference on Pattern Recognition (ICPR).

% Kay H. Brodersen & Cheng Soon Ong, ETH Zurich, Switzerland
% $Id: prc_stats_empirical.m 5529 2010-04-22 21:10:32Z bkay $
% -------------------------------------------------------------------------
function [TPR, FPR, PPV, AUC, AP] = prc_stats_empirical(targs, dvs)
    
    % Check input
    assert(all(size(targs)==size(dvs)));
    assert(all(targs==-1 | targs==1));
    
    % Sort decision values and true labels according to decision values
    n = length(dvs);
    [dvs_sorted,idx] = sort(dvs,'ascend'); 
    targs_sorted = targs(idx);
    
    
    
    % Inititalize accumulators
    TPR = repmat(NaN,1,n+1);
    FPR = repmat(NaN,1,n+1);
    PPV = repmat(NaN,1,n+1);
    
    % Now slide the threshold along the decision values (the threshold
    % always lies in between two values; here, the threshold represents the
    % decision value immediately to the right of it)
    for thr = 1:length(dvs_sorted)+1
        
        TP = sum(targs_sorted(thr:end)>0);
        FN = sum(targs_sorted(1:thr-1)>0);
        TN = sum(targs_sorted(1:thr-1)<0);
        FP = sum(targs_sorted(thr:end)<0);
       
        
        TPR(thr) = TP/(TP+FN);
        FPR(thr) = FP/(FP+TN);
        PPV(thr) = TP/(TP+FP);
    end
     
    % Compute empirical AUC
    [tmp,tmp,tmp,AUC] = perfcurve(targs,dvs,1);
    
    % Compute empirical AP
    AP = abs(trapz(TPR(~isnan(PPV)),PPV(~isnan(PPV))));
    
end
