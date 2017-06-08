
function [newSig] = smoothSig(sig)
    [pks, locs] =  findpeaks(sig, 'MINPEAKDISTANCE', 2);
    if size(locs,1) >= 1 || size(locs,2) >= 1
        sig(locs) = [];
    end

    windowSize=5;
    newSig = filter(ones(1,windowSize)/windowSize,1, sig);
end