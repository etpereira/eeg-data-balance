function HOC = getHOC(signal, quantLevels, stp)
    HOC = zeros(1,quantLevels);
    index=1;
    for level=0:stp:stp*(quantLevels-1),
    %%%%
        t=1:size(signal, 1);
        [crossInd,t0] = crossing(signal,t,level);
        quantCross = size(crossInd,2);
        HOC(1,index) = quantCross;
        index = index + 1;
     end
end