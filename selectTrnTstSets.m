%%%%%%%%%%%%%%%%%%%%%%%%
function [trnSetVal, tstSetVal, trnSetAro, tstSetAro] = selectTrnTstSets(percentSplitTrn, HOCforVal, HOCforAro)
    
    %HOCforVal = HOCforVal(randperm(size(HOCforVal,1)),:); % shuffle matrix
    %HOCforAro = HOCforAro(randperm(size(HOCforAro,1)),:); % shuffle matrix
   
    lSetAr = HOCforAro(HOCforAro(:,1)==1,:);
    hSetAr = HOCforAro(HOCforAro(:,1)==2,:);
    
    lSetVa = HOCforVal(HOCforVal(:,1)==1,:);
    hSetVa = HOCforVal(HOCforVal(:,1)==2,:);
    
    
    quantLowAro = sum(HOCforAro(:,1) == 1);
    quantHighAro = sum(HOCforAro(:,1) == 2);
    
    quantLowVal = sum(HOCforVal(:,1) == 1);
    quantHighVal = sum(HOCforVal(:,1) == 2);
    
    
    assert(quantLowAro > 2, 'eanes: min value must be higher than 2');
    assert(quantHighAro > 2, 'eanes: min value must be higher than 2');
    assert(quantLowVal > 2, 'eanes: min value must be higher than 2');
    assert(quantHighVal > 2, 'eanes: min value must be higher than 2');
    
    quantTrnValL = ceil(percentSplitTrn*quantLowVal);
    quantTrnValH = ceil(percentSplitTrn*quantHighVal);
    
    quantTstValL = quantLowVal-quantTrnValL;%ceil((1-percentSplitTrn)*quantLowVal);
    quantTstValH = quantHighVal-quantTrnValH;%ceil((1-percentSplitTrn)*quantHighVal);
    
    if quantTstValL == 0
        quantTstValL = 1;
        quantTrnValL = quantTrnValL - 1;
    end
    
    if quantTstValH == 0
        quantTstValH = 1;
        quantTrnValH = quantTrnValH - 1;
    end
    
    quantTrnAroL = ceil(percentSplitTrn*quantLowAro);
    quantTrnAroH = ceil(percentSplitTrn*quantHighAro);
    
    quantTstAroL = quantLowAro-quantTrnAroL;%ceil((1-percentSplitTrn)*quantLowAro);
    quantTstAroH = quantHighAro-quantTrnAroH;%ceil((1-percentSplitTrn)*quantHighAro);
    
    
    if quantTstAroL == 0
        quantTstAroL = 1;
        quantTrnAroL = quantTrnAroL - 1;
    end
    
    if quantTstAroH == 0
        quantTstAroH = 1;
        quantTrnAroH = quantTrnAroH - 1;
    end
    
    
    assert(quantTrnValL > 0, 'eanes: zero value not allowed');
    assert(quantTrnValH > 0, 'eanes: zero value not allowed');
    assert(quantTrnAroL > 0, 'eanes: zero value not allowed');
    assert(quantTrnAroL > 0, 'eanes: zero value not allowed');
    assert(quantTrnValL < 40, 'eanes: maximum value is 39');
    assert(quantTrnValH < 40, 'eanes: maximum value is 39');
    assert(quantTrnAroL < 40, 'eanes: maximum value is 39');
    assert(quantTrnAroL < 40, 'eanes: maximum value is 39');
    
    assert(quantTstValL > 0, 'eanes: zero value not allowed');
    assert(quantTstValH > 0, 'eanes: zero value not allowed');
    assert(quantTstAroL > 0, 'eanes: zero value not allowed');
    assert(quantTstAroL > 0, 'eanes: zero value not allowed');
    assert(quantTstValL < 40, 'eanes: maximum value is 39');
    assert(quantTstValH < 40, 'eanes: maximum value is 39');
    assert(quantTstAroL < 40, 'eanes: maximum value is 39');
    assert(quantTstAroL < 40, 'eanes: maximum value is 39');
    
        
    trnSetValAux = zeros(quantTrnValL+quantTrnValH,size(HOCforVal,2));
    trnSetValAux(1:quantTrnValL,:) = lSetVa(1:quantTrnValL,:);
    trnSetValAux(quantTrnValL+1:end,:) = hSetVa(1:quantTrnValH,:);
    
    tstSetVal = zeros(quantTstValL+quantTstValH,size(HOCforVal,2));
    tstSetVal(1:quantTstValL,:) = lSetVa(quantTrnValL+1:end,:);
    tstSetVal(quantTstValL+1:end,:) = hSetVa(quantTrnValH+1:end,:);
            
    trnSetAroAux = zeros(quantTrnAroL+quantTrnAroH,size(HOCforAro,2));
    trnSetAroAux(1:quantTrnAroL,:) = lSetAr(1:quantTrnAroL,:);
    trnSetAroAux(quantTrnAroL+1:end,:) = hSetAr(1:quantTrnAroH,:);
    
    tstSetAro = zeros(quantTstAroL+quantTstAroH,size(HOCforAro,2));
    tstSetAro(1:quantTstAroL,:) = lSetAr(quantTrnAroL+1:end,:);
    tstSetAro(quantTstAroL+1:end,:) = hSetAr(quantTrnAroH+1:end,:);
    
    [trnSetVal] = createSyntheticSamples(trnSetValAux);
    [trnSetAro] = createSyntheticSamples(trnSetAroAux);
end
