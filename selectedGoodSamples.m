%%%%%%%%%%%%%%%%%%%%%%%%
%only samples which valence and arousal labels are different from medium
%first feature
function [HOCforVal, HOCforAro] = selectedGoodSamples(HOC, valLabels, aroLabels)
    HOCforVal = [];
    HOCforAro = [];
    for i=1:size(HOC, 1)
        if valLabels(i,1) ~= 0
            HOCforVal = [HOCforVal; valLabels(i,1) HOC(i,:)];
        end
        if aroLabels(i,1) ~= 0
            HOCforAro = [HOCforAro; aroLabels(i,1) HOC(i,:)];
        end
    end
end