%%%%%%%%%%%%%%%%%%%%%%%%
%option == 1 =: avg std
function [replicas] = replicateSample(origSet, option, quantRep)
    replicas = zeros(quantRep, size(origSet,2)-1);
    if option == 1
        sig = origSet(:,2:size(origSet,2));
        meanSig = mean(sig);
        if size(sig,1) > 1
            stdSig = std(sig);
            %randMat = randi([0 1], quantRep, size(origSet,2)-1);
            randMat = randi([0 3], quantRep, size(origSet,2)-1);
            for i = 1:quantRep
                replicas(i,:) = meanSig + stdSig.*randMat(i,:);
            end
        end
    end
        
end
