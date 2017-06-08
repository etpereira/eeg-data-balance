%%%%%%%%%%%%%%%%%%%%%%%%
function [syntSet] = createSyntheticSamples(trnSet)
    quantL = sum(trnSet(:,1) == 1);
    quantH = sum(trnSet(:,1) == 2);
    
    lSet = trnSet(trnSet(:,1)==1,:);
    hSet = trnSet(trnSet(:,1)==2,:);
    
    if quantL > quantH
        frac = quantL/quantH;
        quantNewSamples = frac*quantH - quantH;
        %meanSig = hSet(:,2:size(hSet,2));
        %if size(meanSig, 1) > 1
        %    meanSig = mean(meanSig);
        %end
            
        %[noisedReplicas] = createNoisedReplicas(meanSig, quantNewSamples);
        [noisedReplicas] = replicateSample(hSet, 1, quantNewSamples);
        noisedReplicasAux = [2*ones(quantNewSamples,1) noisedReplicas];
        hSet = [hSet; noisedReplicasAux];
        %[IDXA,CA] = kmeans(, 2, 'MaxIter', 100, 'emptyaction',
        %'singleton');% returns the k cluster centroid locations in the k-by-p matrix C.
    elseif quantH > quantL
        frac = quantH/quantL;
        quantNewSamples = frac*quantL - quantL;
        %meanSig = lSet(:,2:size(lSet,2));
        %if size(meanSig,1) > 1
        %    meanSig = mean(meanSig);
        %end
        %[noisedReplicas] = createNoisedReplicas(meanSig, quantNewSamples);
        [noisedReplicas] = replicateSample(lSet, 1, quantNewSamples);
        noisedReplicasAux = [ones(quantNewSamples,1) noisedReplicas];
        lSet = [lSet; noisedReplicasAux];
    end
    syntSet = [lSet; hSet];
end
