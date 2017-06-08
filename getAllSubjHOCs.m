
function [HOC, valLabels, aroLabels] = getAllSubjHOCs(i, outDirValence, outDirArousal)

       quantLevels=10;
       stp=2;
       percentSplitTrn = 0.8;
       disp(int2str(i));
       allSuData = loadSubjectByIndex(i);
       
       %https://en.wikipedia.org/wiki/10-20_system_%28EEG%29#/media/File:21
       %_electrodes_of_International_10-20_system_for_EEG.svg
       %%%%
       HOC = [];
       valLabels = [];
       aroLabels = [];
       %video/trial x channel x dat
       for vid=1:40,
            allSuDataFp1 = allSuData.data(vid,1,:);
            allSuDataFp2 = allSuData.data(vid,17,:);
            allSuDataF3 = allSuData.data(vid,3,:);
            allSuDataF4 = allSuData.data(vid,20,:);
       
            allSuDataFp1 = allSuDataFp1(:);
            allSuDataFp2 = allSuDataFp2(:);
            allSuDataF3 = allSuDataF3(:);
            allSuDataF4 = allSuDataF4(:);
            
            
            HOCFp1 = getHOC(smoothSig(allSuDataFp1), quantLevels, stp);
            HOCFp2 = getHOC(smoothSig(allSuDataFp2), quantLevels, stp);
            HOCF3 = getHOC(smoothSig(allSuDataF3), quantLevels, stp);
            HOCF4 = getHOC(smoothSig(allSuDataF4), quantLevels, stp);
       
            HOC = [HOC; HOCFp1 HOCFp2 HOCF3 HOCF4];
       end
       [valLabels, aroLabels] = getAllValAndAroLabels(allSuData);
       [HOCforVal, HOCforAro] = selectedGoodSamples(HOC, valLabels, aroLabels);
       
       [trnSetVal, tstSetVal, trnSetAro, tstSetAro] = selectTrnTstSets(percentSplitTrn, HOCforVal, HOCforAro);
       
       auxStr = [outDirValence '/trn/su' num2str(i) '.libsvm']; 
       saveSubjectData(auxStr, trnSetVal(:,2:end), trnSetVal(:,1));
       
       auxStr = [outDirValence '/tst/su' num2str(i) '.libsvm']; 
       saveSubjectData(auxStr, tstSetVal(:,2:end), tstSetVal(:,1));
       
       auxStr = [outDirArousal '/trn/su' num2str(i) '.libsvm']; 
       saveSubjectData(auxStr, trnSetAro(:,2:end), trnSetAro(:,1));
       
       auxStr = [outDirArousal '/tst/su' num2str(i) '.libsvm']; 
       saveSubjectData(auxStr, tstSetAro(:,2:end), tstSetAro(:,1));
end
%%%%%%%%%%%%%%%%%%%%%%%%