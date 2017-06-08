function eegDataAugmentation(outDirValence, outDirArousal)

       quantLevels=5;
       stp=2;
       quantSubjs=1;
       for i=1:quantSubjs

           disp(int2str(i));
           allSuData = loadSubjectByIndex(i);
           for cases=1:2%10
               caseStr = ['case: ' int2str(cases)];
               disp(caseStr)
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

                    HOCFp1 = getHOC(augmentFunc(cases, allSuDataFp1), quantLevels, stp);
                    HOCFp2 = getHOC(augmentFunc(cases, allSuDataFp2), quantLevels, stp);
                    HOCF3 = getHOC(augmentFunc(cases, allSuDataF3), quantLevels, stp);
                    HOCF4 = getHOC(augmentFunc(cases, allSuDataF4), quantLevels, stp);

                    HOC = [HOC; HOCFp1 HOCFp2 HOCF3 HOCF4];
               end
               [valLabels, aroLabels] = getAllValAndAroLabels(allSuData);
               
               HOCVal = zeros(size(HOC,1), size(HOC,2)+1);
               HOCAro = zeros(size(HOC,1), size(HOC,2)+1);

               HOCVal(:,1) = valLabels(:,1);
               HOCVal(:,2:end) = HOC;

               HOCAro(:,1) = aroLabels(:,1);
               HOCAro(:,2:end) = HOC;

               HOCVal(HOCVal(:,1)==0,:) = [];
               HOCAro(HOCAro(:,1)==0,:) = [];
               
               oneValues = sum(HOCVal(:,1)==1);
               twoValues = sum(HOCVal(:,1)==2);
               
               %the response variable of the unbalanced dataset. It must be
               %a binary factor where the majority class is coded as 0 and the minority as 1.
               if oneValues > twoValues
                    HOCVal(HOCVal(:,1)==1,1) = 0;
                    HOCVal(HOCVal(:,1)==2,1) = 1;
               else
                   HOCVal(HOCVal(:,1)==2,1) = 0;
                   HOCVal(HOCVal(:,1)==1,1) = 1;
               end
               
               
               oneValues = sum(HOCAro(:,1)==1);
               twoValues = sum(HOCAro(:,1)==2);
               
               if oneValues > twoValues
                    HOCAro(HOCAro(:,1)==1,1) = 0;
                    HOCAro(HOCAro(:,1)==2,1) = 1;
               else
                   HOCAro(HOCAro(:,1)==2,1) = 0;
                   HOCAro(HOCAro(:,1)==1,1) = 1;
               end
               
               auxStr = [outDirValence '/su' num2str(i) '.csv']; 
               dlmwrite(auxStr,HOCVal, 'delimiter', ',', '-append');

               auxStr = [outDirArousal '/su' num2str(i) '.csv']; 
               dlmwrite(auxStr, HOCAro, 'delimiter', ',', '-append');
           end
       end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [outData] = augmentFunc(option, inData)
    switch option
        case 1
          [outData] = manySmoothSig(inData, 2, 1);
        case 2
            [outData] = manySmoothSig(inData, 3, 1);
        case 3
            [outData] = manySmoothSig(inData, 4, 1);
        case 4
            [outData] = manySmoothSig(inData, 5, 1);
        case 5
            [outData] = manySmoothSig(inData, 6, 1);
        case 6
            [outData] = manySmoothSig(inData, 7, 1);
        case 7
            [outData] = manySmoothSig(inData, 8, 1);
        case 8
            [outData] = manySmoothSig(inData, 9, 1);
        case 9
            [outData] = manySmoothSig(inData, 10, 1);
        case 10
            [outData] = manySmoothSig(inData, 11, 1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [newSig] = manySmoothSig(sig, windowSize, peaksYesNo)
    if peaksYesNo == 1
        [pks, locs] =  findpeaks(sig, 'MINPEAKDISTANCE', 2);
        if size(locs,1) >= 1 || size(locs,2) >= 1
            sig(locs) = [];
        end
    end
    newSig = filter(ones(1,windowSize)/windowSize,1, sig);
end