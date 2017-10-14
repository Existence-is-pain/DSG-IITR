# DSG-IITR
## Classification of Mushrooms as poisonous or edible ##
* A data set of 24 charecteristics of mushrooms is taken for analysis and creating a model for further classification.
* The dataset includes descriptions of hypothetical samples corresponding to 23 species of gilled mushrooms in the Agaricus and Lepiota Family Mushroom drawn from The Audubon Society Field Guide to North American Mushrooms (1981). Each species was identified as definitely edible or definitely poisonous. The aim of this problem was to identify the poisonous and edible class. 
* The training set has 5686 records with 24 attributes. Thus, Principal Component Analysis(PCA) is not very much required as the dataset is not huge.
* After a thorough inspection and analysis of data few models were tried out on the training data and then the most effective one was chosen based on their performance. It was then used to classify the mushrooms in the test data.

## Prerequisites and installation ##
* R version 3.4.0 (2017-04-21) -- "You Stupid Darkness".
* RStudio.
* R libraries used - 'mice', 'VIM', 'OneR', 'ggplot2', 'rpart', 'rpart.plot', 'RWeka'. These can be easily installed using RStudio.
