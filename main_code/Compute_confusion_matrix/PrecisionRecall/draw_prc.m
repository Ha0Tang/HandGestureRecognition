function draw_prc(targs, dvs,PRC_or_ROC)
% Modified by иЇзг for multi-classification 
%
% Simple demonstration of different methods for estimating a
% precision-recall curve (PRC).
%
% Generates decision values from a binormal distribution and plots true vs.
% empirical vs. model-based quantities derived from the confusion matrix of
% the simulated classifier.
%
% Usage:
%     prc_demo
%
% Literature:
%     K.H. Brodersen, C.S. Ong, K.E. Stephan, J.M. Buhmann (2010). The
%     binormal assumption on precision-recall curves. In: Proceedings of
%     the 20th International Conference on Pattern Recognition (ICPR).
% Kay H. Brodersen & Cheng Soon Ong, ETH Zurich, Switzerland
% $Id: prc_demo.m 5529 2010-04-22 21:10:32Z bkay $


% -------------------------------------------------------------------------
% Compute empirical curves
[TPR_emp, FPR_emp, PPV_emp] = prc_stats_empirical(targs, dvs);

% Compute smooth curves (binormal model)
[TPR_bin, FPR_bin, PPV_bin] = prc_stats_binormal(targs, dvs, false);

% Compute smooth curves (alpha-binormal model)
[TPR_abin, FPR_abin, PPV_abin] = prc_stats_binormal(targs, dvs, true);


% -------------------------------------------------------------------------
cols = [200 45 43; 37 64 180; 0 176 80; 0 0 0]/255;
if PRC_or_ROC==0
    % Plot PR curves
    figure; hold on;
    plot(TPR_emp, PPV_emp, '-o', 'color', cols(1,:), 'linewidth', 2);
    %plot(TPR_bin, PPV_bin, '-', 'color', cols(2,:), 'linewidth', 2);
    plot(TPR_abin, PPV_abin, '-', 'color', cols(3,:), 'linewidth', 2);
    axis([0 1 0 1]);
    %xlabel('TPR (recall)'); ylabel('PPV (precision)'); title('PR curves');
    xlabel('Recall'); ylabel('Precision');
    set(gca, 'box', 'on');
elseif PRC_or_ROC==1
    % Plot ROC curves
    figure; hold on;
    plot(FPR_emp, TPR_emp, '-o', 'color', cols(1,:), 'linewidth', 2);
    %plot(FPR_bin, TPR_bin, '-', 'color', cols(2,:), 'linewidth', 2);
    plot(FPR_abin, TPR_abin, '--', 'color', cols(3,:), 'linewidth', 2);
    plot([0 1], [0 1], '-', 'color', [0.7 0.7 0.7], 'linewidth', 2);
    axis([0 1 0 1]);
    xlabel('FPR'); ylabel('TPR'); title('ROC curves');
    set(gca, 'box', 'on');
else
    % Plot ROC curves
    figure; hold on;
    plot(FPR_emp, TPR_emp, '-o', 'color', cols(1,:), 'linewidth', 2);
    %plot(FPR_bin, TPR_bin, '-', 'color', cols(2,:), 'linewidth', 2);
    plot(FPR_abin, TPR_abin, '--', 'color', cols(3,:), 'linewidth', 2);
    plot([0 1], [0 1], '-', 'color', [0.7 0.7 0.7], 'linewidth', 2);
    axis([0 1 0 1]);
    xlabel('FPR'); ylabel('TPR'); title('ROC curves');
    set(gca, 'box', 'on');
    
    % Plot PR curves
    figure; hold on;
    plot(TPR_emp, PPV_emp, '-o', 'color', cols(1,:), 'linewidth', 2);
    %plot(TPR_bin, PPV_bin, '-', 'color', cols(2,:), 'linewidth', 2);
    plot(TPR_abin, PPV_abin, '-', 'color', cols(3,:), 'linewidth', 2);
    axis([0 1 0 1]);
    %xlabel('TPR (recall)'); ylabel('PPV (precision)'); title('PR curves');
    xlabel('Recall'); ylabel('Precision');
    set(gca, 'box', 'on');
end
end