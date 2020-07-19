%  Matlab package for statistics and visualization of classification results and many other problems.
%  
%  Author£º Created by Piji Li (pagelee.sd@gmail.com)  
%           Blog: www.zhizhihu.com;
%           QQ:379115886;
%  Date:    Dec. 2010
%% initialization
clc;
clear;
load num_in_class;    % instance number of each class
load actual_label;    % actual label of each instance
load predict_label;   % predicted label of your experiments
load decision_values; % deccision values of each instance in your classification experiments(e.g. dec_values of Libsvm)
load name_class;      % name of each class

%% compute and visualize the confusion matrix
addpath ConfusionMatrices; % package for computing confusion matrix

[confusion_matrix]=compute_confusion_matrix(predict_label,num_in_class,name_class);


%%  compute and visualize the precision/recall curve and ROC
addpath PrecisionRecall;
label_or_decision='decision'; % use label('label') as decision or decision_values('decision') as decision decision will be better.
PRC_or_ROC=0;                 % 0 for PRC, 1 for ROC, 2 for both;

compute_precision_recall(predict_label,decision_values,actual_label,num_in_class,label_or_decision,PRC_or_ROC);


%% compute accuracy and F-measure, etc.
addpath AccuracyF;
classes = [1:max(max(actual_label),max(predict_label))];
fprintf('Begin computing confus,accuracy,numcorrect,precision,recall,F...\n');
[confus,accuracy,numcorrect,precision,recall,F,PatN,MAP,NDCGatN]=compute_accuracy_F(actual_label,predict_label,classes)
fprintf('Finish.\n');


