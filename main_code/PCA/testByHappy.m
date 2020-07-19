clear all; clc;
% data=rand(100,10);  % artificial data set of 100 variables (genes) and 10 samples
% [W, pc] = princomp(data'); pc=pc'; W=W';
% plot(pc(1,:),pc(2,:),'.'); 
% title('{\bf PCA} by princomp'); xlabel('PC 1'); ylabel('PC 2')


% 每一行是一个数据，在这个例子中，数据有10维，想要将其降至4维，Y就是最后的结果
fea_train = rand(7,10);
fea_test = rand(7,10);
options=[];
options.ReducedDim=5;
[eigvector_train,eigvalue_train] = PCA(fea_train,options);
[eigvector_test,eigvalue_test] = PCA(fea_test,options);
train_data = fea_train*eigvector_train;
test_data = fea_test*eigvector_test;


