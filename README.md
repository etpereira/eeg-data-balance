# eeg-data-balance
The role of data balancing for emotion classification using EEG signals

This repository has some data and code used in the paper with the same title presented in International Conference on Digital Signal Processing, 2016.

If you use some of this code, please cite this paper:

@inproceedings{pereira_gomes_2016,
  title = {The role of data balancing for emotion classification using EEG signals},
  author       = {Eanes Torres Pereira and Herman Martins Gomes},
  year         = {2016},
  booktitle    = {International Conference on Digital Signal Processing},
  location     = {Beijing, China},
  pages        = {1-6},
}

The abstract: In this paper, we demonstrate the role of data balancing in experimental evaluation of emotion classification systems based on electroencephalogram (EEG) signals. ADASYN method was employed to create a balanced version of the DEAP EEG dataset. Experiments considered Support Vector Machine classifiers trained with HOC and PSD features to predict valence and arousal affective dimensions. Using signals from only four channels (Fp1, Fp2, F3 and F4) we obtained, after balancing, accuracies of 98% (valence) and 99% (arousal) for subject dependent experiments with three classes, and 85% (valence) and 87% (arousal) for two-class classification. However, accuracies for subject independent experiments were lower than the ones obtained using imbalanced datasets. We obtained accuracies of 52% (valence) and of 49% (arousal) for two classes, and accuracies of 36% (valence) and of 31% (arousal) for three classes. To explain the low accuracies in subject independent experiments, we present arguments and empirical evidence using correlations between the percentage of samples for each class and the accuracies obtained by approaches which did not use balanced datasets. 

The role of data balancing for emotion classification using EEG signals. Available from: https://www.researchgate.net/publication/309396729_The_role_of_data_balancing_for_emotion_classification_using_EEG_signals [accessed Jun 8, 2017].
