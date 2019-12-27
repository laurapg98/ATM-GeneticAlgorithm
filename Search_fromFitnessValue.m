%% Given a number of the fitness function, search for the bits of 'population' matrix
function bits = Search_fromFitnessValue(valueF, FitnessVector, population)
    
    bits=[];
	found=false;
    i=1;
    while(i<=length(FitnessVector) && found==false)
        if (FitnessVector(i)==valueF)
            bits=population(i,:);
            found=true;
        end
        i=i+1;
    end
    
end

