function [confus,accuracy,numcorrect,precision,recall,F,PatN,MAP,NDCGatN] = compute_accuracy_F (actual,pred,classes)
% Modified by иЇзг(www.shamoxia.com) from:
% GETCM : gets confusion matrices, precision, recall, and F scores
% [confus,numcorrect,precision,recall,F] = getcm (actual,pred,[classes])
%
% actual is a N-element vector representing the actual classes
% pred is a N-element vector representing the predicted classes
% classes is a vector with the numbers of the classes (by default, it is 1:k, where k is the
%    largest integer to appear in actual or pred.
%
% dinoj@cs.uchicago.edu , Apr 2005, modified July 2005

if size(actual,1) ~= size(pred,1)
    pred=pred';
end
if nargin < 3
    classes = [1:max(max(actual),max(pred))];
end

%%
PatN=[];
MAP=0;
NDCGatN=[];
num_corr=0;
sum_cp=0;

for i=1:length(actual)
    if actual(i)==pred(i)
        num_corr=num_corr+1;
        sum_cp=sum_cp+num_corr/i;
    end
    PatN(i)=num_corr/i;
end
if num_corr~=0
    MAP=sum_cp/num_corr;
end
%%

numcorrect = sum(actual==pred);
accuracy = numcorrect/length(actual);
for i=1:length(classes)
    % confus(i,:) = hist(pred,classes);
    a = classes(i);
    d = find(actual==a);     % d has indices of points with class a
    for j=1:length(classes)
        confus(i,j) = length(find(pred(d)==classes(j)));
    end
end

precision=[];
recall=[];
F=[];


for i=1:length(classes)
    S = sum(confus(i,:));
    if nargout>=4
        if S
            recall(i) = confus(i,i) / sum(confus(i,:));
        else
            recall(i) = 0;
        end
    end
    S =  sum(confus(:,i));
    if nargout>=3
        if S
            precision(i) = confus(i,i) / S;
        else
            precision(i) = 0;
        end
    end
    if nargout>=5
        if (precision(i)+recall(i))
            F(i) = 2 * (precision(i)*recall(i)) / (precision(i)+recall(i));
        else
            F(i) = 0;
        end
    end
end

