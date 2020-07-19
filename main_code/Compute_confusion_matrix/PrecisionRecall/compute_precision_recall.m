function compute_precision_recall(predict_label,decision_values,actual_label,num_in_class,label_or_decision,PRC_or_ROC)

%
%  Author£º Page( Ø§×Ó)
%           Blog: www.shamoxia.com;
%           QQ:379115886;
%           Email: peegeelee@gmail.com
% -------------------------------------------------------------------------

num_class=length(num_in_class);


for ci=1:num_class
    c_start=sum(num_in_class(1:ci-1))+1;
    c_end=sum(num_in_class(1:ci));
    
    targs=-ones(1,length(actual_label));
    positive_i=find(actual_label==ci);
    targs(positive_i)=1;
    
    if strcmp(label_or_decision,'label')
        pre_nag=find(predict_label~=ci);
        predict_label(pre_nag)=-predict_label(pre_nag);
        dvs=predict_label';
    end
    if strcmp(label_or_decision,'decision')
        dec=decision_values(:,ci);
        pre_nag=find(predict_label~=ci);
        dec(pre_nag)=-dec(pre_nag);
        dvs=dec';
    end
    
    draw_prc(targs,dvs,PRC_or_ROC)
    
%     fprintf('Press any key to get the %d th class PRC...\n',ci);
%     pause;
end

end


