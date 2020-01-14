%% Computes the roulette wheel

function choice = RouletteWheel(NoElitism)

    accumulation = cumsum(NoElitism(:,1));
    accumulated =  accumulation(end);
    cake = zeros(size(NoElitism,1),1);
    
    for index = 1 : size(NoElitism,1)
        cake(index,1) = (1 - (NoElitism(index,1)/accumulated))/(size(NoElitism,1)-1)*10000;
    end
    for a=1:1:length(cake)
        Ruleta(a)=rand()*cake(a);
        Max=max(Ruleta);
        if Ruleta(a)==Max
            index=a;         
        end
    end
    choice = index;

end