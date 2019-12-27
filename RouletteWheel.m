%% Computes the roulette wheel

function sum = RouletteWheel(NoElitism)
    
    Probabilities=[];
    sum=0;
    i=1;
    while(i<=length(NoElitism))
        Probabilities(i)=(1/NoElitism(i))/(100/length(NoElitism));
        sum=sum+Probabilities(i);
        i=i+1;
    end

end