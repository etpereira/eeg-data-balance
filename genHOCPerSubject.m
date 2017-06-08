%option indications the type of used noise,
%   0 for no noise;
%   1 for white Gaussian noise (wgn)
function genHOCPerSubject(option, outDirValence, outDirArousal, nFolds)
   %[valences, arousals, dominances, likings] = dataForPaper1();
   quantSubjs=32;
   
   for i=1:quantSubjs, 
       %disp(quantSubjs)
       [HOC] = getAllSubjHOCs(i, outDirValence, outDirArousal);
   end
end

