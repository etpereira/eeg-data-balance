%%%%%%%%%%%%%%%%%%%%%%%%
function [valLabels, aroLabels] = getAllValAndAroLabels(allSuData)
    valLabels = zeros(40,1);  %medium label == 0
    aroLabels = zeros(40,1);%medium label == 0
    for i=1:40
        if (allSuData.labels(i,1) >= 6)
            valLabels(i,1) = 2; %high label
        elseif (allSuData.labels(i,1) <= 4)
            valLabels(i,1) = 1; %low label
        end
        
        if (allSuData.labels(i,2) >= 6)
            aroLabels(i,1) = 2; %high label
        elseif (allSuData.labels(i,2) <= 4)
            aroLabels(i,1) = 1; %low label
        end
    end
end
