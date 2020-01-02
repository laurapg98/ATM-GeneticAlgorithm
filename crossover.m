%% Computes two new individuals from two previously selected
    % One-point crossover in a random point
    
    % With cut_point = 1
        % f1 X-X-X-X-X-X --> Jr1 Y-Y-Y-Y-Y-Y
        % f2 Y-Y-Y-Y-Y-Y --> Jr2 Y-X-X-X-X-X
    %With cut_point = 6
        % f1 X-X-X-X-X-X --> Jr1 X-X-X-X-X-Y
        % f2 Y-Y-Y-Y-Y-Y --> Jr2 Y-Y-Y-Y-Y-X
        
function [solution_jr_1,solution_jr_2] = crossover(solution_1,solution_2)

    flights_1 = zeros(size(solution_1,2)/6,6);
    flights_2 = zeros(size(solution_2,2)/6,6);
    for index = 1:1:size(solution_1,2)/6 % divide bits per FPs
        for i = 1:6
            flights_1(index,i) = solution_1(1,6*(index-1)+i);
            flights_2(index,i) = solution_2(1,6*(index-1)+i);
        end
    end
    
    cut_point=randi([1 6],1,1);
    
    for i = 1:1:size(solution_1,2)/6
        for j = 1:1:6
            if j < cut_point
                solution_jr_1_temp(i,j) = flights_1(i,j);
                solution_jr_2_temp(i,j) = flights_2(i,j);
            else
                solution_jr_1_temp(i,j) = flights_2(i,j);
                solution_jr_2_temp(i,j) = flights_1(i,j);
            end 
        end
    end
    
    solution_jr_1 = zeros(1,size(solution_1,2));
    solution_jr_2 = zeros(1,size(solution_2,2));
    i = 1;
    for j = 1:6:(size(solution_1,2)-6)
        solution_jr_1(1,j:j+5) = solution_jr_1_temp(i,:);
        solution_jr_2(1,j:j+5) = solution_jr_2_temp(i,:);
        i = i + 1;
    end
    
end

