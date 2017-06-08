function [valences, arousals, dominances, likings] = dataForPaper1()
    auxSumsH = []; % maior ou igual a 6
    auxSumsL = []; % menor ou igual a 4
    auxSumsE = []; % maior que 4 e menor que 6
    for i=1:32, 
       disp(int2str(i));
       suTrn = loadSubjectByIndex(i);
       %video/trial x label (valence, arousal, dominance, liking)
       a = sum(suTrn.labels >= 6);
       b = sum(suTrn.labels <= 4);
       c = sum(suTrn.labels > 4 & suTrn.labels < 6);
       auxSumsH = [auxSumsH; a];
       auxSumsL = [auxSumsL; b];
       auxSumsE = [auxSumsE; c];
    end
    
    %sum(auxSumsH)/1280
    %sum(auxSumsL)/1280
    %sum(auxSumsE)/1280
    
    %disp('per subject')
    
    H = auxSumsH/40;
    L = auxSumsL/40;
    E = auxSumsE/40;
    
    valences = [L(:,1) E(:,1) H(:,1)];
    arousals = [L(:,2) E(:,2) H(:,2)];
    dominances = [L(:,3) E(:,3) H(:,3)];
    likings = [L(:,4) E(:,4) H(:,4)];
end