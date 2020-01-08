function FitnessVectorSorted_new = index_sort(FitnessVector,FitnessVectorSorted)
% This function assigns the indexes of the sorted fitness vectors to know
% which solution corresponds to each fitness score
    FitnessVectorSorted_new = zeros(size(FitnessVectorSorted,1),2);
    FitnessVectorSorted_new(:,1) = FitnessVectorSorted(:,1);

% index_find = zeros(size(FitnessVectorSorted_new,1),1);
%     for qwe = 1:1:size(FitnessVectorSorted,1)
%         index_find(qwe,1) = find(FitnessVector==FitnessVectorSorted(qwe,1));
%     end
% FitnessVectorSorted_new(:,2) = index_find(:,1);
    
    for i = 1:1:size(FitnessVector,1)
        for j = 1:1:size(FitnessVectorSorted,1)
            if FitnessVector(i,1) == FitnessVectorSorted(j,1)
                index_find = i;
                if FitnessVectorSorted_new(j,2) == 0
                    FitnessVectorSorted_new(j,2) = index_find;
%                     j = size(FitnessVectorSorted,1)+1;
                    break
                end
            end
        end
    end
end

