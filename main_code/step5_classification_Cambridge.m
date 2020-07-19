%% train and test data
clc; clear all;

maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_6entropy_4096\' ;
maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_9entropy_4096\' ;

subdir = dir( maindir );
num_class_train = 20;
num_class_test =100-num_class_train;
train_data =[];
test_data =[];
train_label=[];
test_label=[];
num_in_class =[];
% Each row is a data instance.
for class_num = 1:9
    train_label = [train_label; class_num*ones(num_class_train, 1)];
    test_label = [test_label; class_num*ones(num_class_test, 1)];
    num_in_class=[num_in_class; num_class_test]; % 用于最后画混淆矩阵
end

%% predict
nRunning=20;
addpath(genpath('liblinear'))
addpath(genpath('spams-matlab'))
addpath(genpath('PCA'))
tic
for running_times = 1:nRunning    
    train_data=[]; test_data=[];
    rand_num=randperm(num_class_train+num_class_test);                             
    rand_num= rand_num';                                                          
    index_train = rand_num(1:num_class_train,:);
    index_test = rand_num(num_class_train + 1:num_class_train+num_class_test,:);
    
    for i = 1 : length( subdir )
        if( isequal( subdir( i ).name, '.' ) || ...
            isequal( subdir( i ).name, '..' ) )   % 如果不是目录跳过
            continue;
        end
        matpath = fullfile( maindir, subdir( i ).name );
        matdata = load( matpath );   % 这里进行你的读取操作
       
        train_data = [train_data; matdata.feature(index_train, :)];
        test_data = [test_data; matdata.feature(index_test, :)]; 
        
    end
    
    model = train(double(train_label), sparse(double(train_data)), '-c 1');
    [predict_label(:, running_times), accuracy, dec_values] = predict(double(test_label), sparse(double(test_data)), model);
    Accuracy(running_times) = accuracy(1); 
    str = sprintf('loop: %d --> ratio: %6.4f', running_times, Accuracy(running_times));
    disp(str) 
end
toc
    acc = Accuracy;  
    acc_mean = mean(acc)
    acc_std=std(acc) 

%% plot
% name_class={'FlatLeft', 'FlatRight', 'FlatCont', 'SpreLeft', 'SpreRight', 'SpreCont', 'VLeft', 'VRight', 'VCont'};
% addpath(genpath('Compute_confusion_matrix'))
% max_id = find(acc==max(acc));
% if size(max_id,2)>1
%     max_id = max_id(1);
% end
% % num_in_class:
% [confusion_matrix]=compute_confusion_matrix(predict_label(:,max_id),num_in_class,name_class);
