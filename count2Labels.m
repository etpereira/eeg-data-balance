function [valences, arousals, dominances, likings] = count2Labels()
    auxSumsH = []; % maior ou igual a 5
    auxSumsL = []; % menor que 5
   
    for i=1:32, 
       disp(int2str(i));
       suTrn = loadSubjectByIndex(i);
       %video/trial x label (valence, arousal, dominance, liking)
       a = sum(suTrn.labels >= 5);
       b = sum(suTrn.labels < 5);
   
       auxSumsH = [auxSumsH; a];
       auxSumsL = [auxSumsL; b];
       
    end
    
    %disp('per subject')
    
    H = auxSumsH/40;
    L = auxSumsL/40;
        
    valences = [L(:,1) H(:,1)];
    arousals = [L(:,2) H(:,2)];
    dominances = [L(:,3) H(:,3)];
    likings = [L(:,4) H(:,4)];
end