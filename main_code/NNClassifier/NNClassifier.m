%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Authors: Yimo Guo, Guoying Zhao, and Matti Pietikainen          
%             Nearest Classifier using L1 Distance    
% Output: final_accu is the calculated classification accuracy
%         PreLabel is the estimated label for each image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [final_accu,PreLabel] = NNClassifier(Samples_Train,Samples_Test,Labels_Train,Labels_Test)

Train_Model = Samples_Train;
Test_Model = Samples_Test;
numTest = size(Test_Model,2);
numTrain = size(Train_Model,2);

current_test = [];
current_comp = [];
PreLabel = [];
current_value = 0;
min_value = 99999;
class_index = 1;

for index2 = 1:numTest
    current_test = Test_Model(:,index2);
    for index3 = 1:numTrain
        current_comp = Train_Model(:,index3);

        current_value = sum(abs(current_test - current_comp));
        if(current_value<min_value)
            min_value = current_value;
            class_index = Labels_Train(1,index3);
        end
    end
        
    PreLabel = [PreLabel,class_index];
    min_value = 99999;
    class_index = 1;
end

Comp_Label = PreLabel - Labels_Test;
Comp_Label = Comp_Label;
accu_count = 0;
for index3 = 1:size(Comp_Label,2)
    if(Comp_Label(1,index3)==0)
        accu_count = accu_count+1;
    end
end

final_accu = (accu_count/double(size(Comp_Label,2)))*100;
    
        
                
            
            
            