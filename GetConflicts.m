%% Count the number of conflicts in each solution

function Conflicts = GetConflicts(Population,listFPmod,SecDistance,SimTime)

    sizeP=size(Population); % size of the matrix population
    
    Conflicts=zeros(sizeP(1),1); % vector with the number of conflicts of each solution
    
    % chromosomas
    chrom=1; % counter of chromosomas
    while(chrom<sizeP(1))
        % check conflicts
        FPcont=1;
        while(FPcont<sizeP(2))
            FP1=listFPmod(FPcont,:);
            Nconflicts=0;
            i=FPcont+1;
            while(i<=sizeP(2))
                FP2=listFPmod(i,:);
                if(Conflict_2FP(SecDistance,SimTime,FP1,FP2)==true)
                    Nconflicts=Nconflicts+1;
                end
                i=i+1;
            end
            FPcont=FPcont+1;
        end
        
        % save Nconflicts
        Conflicts(chrom,1)=Nconflicts;
        
        chrom=chrom+1;
    end
    
end

