%% Count the number of conflicts in each solution

function Conflicts = GetConflicts(listFPmod,SecDistance,SimTime,numFP)
          
    % check conflicts
    FPcont=1;
    Nconflicts=0;
    while(FPcont<numFP)
        FP1=listFPmod(FPcont,:);
        
        i=FPcont+1;
        while(i<=numFP)
            FP2=listFPmod(i,:);
            if(Conflict_2FP(SecDistance,SimTime,FP1,FP2)==true)
                Nconflicts=Nconflicts+1;
                
            end
            i=i+1;
            
        end
        FPcont=FPcont+1;
    end

    % save Nconflicts
    Conflicts = Nconflicts;
   
end

