
![](Pokémon_images/R_Pokémon_images_logo.png)

# DATA SCIENCE PRACTISING USING POKEMON

## Introducing Pokémon
Pokémon are creatures of all shapes and sizes who live in the wild or alongside humans. The concept of the Pokémon comes from the hobby - quite common in Japan - to collect insects as stated by their creator Satoshi Tajiri. Pokèmon can be wild or tamed by a person called "Trainer". A Pokèmon trainer goals are tipically to complete the Pokédex by collecting all of the available Pokémon species found in the fictional region and to train a team of powerful Pokémon from those he has caught. Just like other lifeforms, Pokémon grow, level up and become more experienced and even, on occasion, evolve into stronger Pokémon.

## The dataset
The dataset contains 801 Pokèmon from 7 generations (1996-2019) and 45 variables. Features refer only to [Pokèmon video games](https://github.com/https://en.wikipedia.org/wiki/Pok%C3%A9mon_(video_game_series)) and not to other products such as [Pokèmon GO](https://github.com/https://en.wikipedia.org/wiki/Pok%C3%A9mon_Go) or [trading card game](https://github.com/https://en.wikipedia.org/wiki/Pok%C3%A9mon_Trading_Card_Game). The original version is available for free download at [Kaggle.com](//github.com/https:https://www.kaggle.com/rounakbanik/pokemon).

## Data preparation
Data preparation includes several steps aimed to improve  the overall quality of the dataset and its aesthetic appearence. The goal of this phase is to make data as consistent as possible. Since often data have been genereated by somebody else caution is a good option in this early stage: any error occurred would affect the accuracy of all analysis.

### Features editing
* ```Is_legendary``` variable according the ```class()``` function turn to be numeric. It is better to consider this feature as factor.
* ```Generation``` has been considered numeric but no Pokémon will come from generation 3.22: the variables has been converted into factor using ronman numerals to display the generation which a Pokémon belong to.
* Make the first header letter capital 
* Encoding ```Classification``` column to proprerly display accent 
* Edit ```Type_1``` and ```Type_2``` to displasy as capital the first letter
* Since ```Type_2``` can be also null ( ```""```) the actual empty level has been replaced with ```None```
* Split ```Ability``` to obtain one column for each
* The ```Capture_rate``` should be a numeric values while is being classed as a factor. The reason lies in the capture rate of ```Minior``` (number 774): this type Pokémon appears to have a different capture rate under different conditions. In our data the actual capture rate for this Pokémon is ```30 (Meteorite)255 (Core)```. Based on the Pokedex descritpion, the canonical value is 30 for its Meteorite form, so we will use this after have converted all rate as factors and replace the wrong one. Aftwer this passage data can be and converted into numeric.

### Data cleaning: missing data
We need first to check the consistency of the data to ensure that there are no missing values: if some missing are present we cand decide to use our knowledge to replace them or simply not to consider entries with missing values. With only 20 Pokémon (18 of which from the first generation) with no ```Height``` nor ```Weight``` the dataset seems to be a fairly complete data set. There are also 98 Pokémon for ```Percentage_male``` value is missing. Since this issue seems not to depend from any factor, after a quick check in the Pokedex we could learn that these are genderless Pokémon (this explain the missing values). A reasonable choise could be to set this values at 0.5, representing an equal spit bewteen male and female.

### Data engineering 
Since each Pokèmon generation belong to a different region a new feature (Region) have been creating ```assign_region``` custom function that is store in the local project folder. The function makes a double check on the Pokedex_Number number and on the Generation to which the Pokémon belongs to assign the proper region name.

#### License
The source icons are (c) Nintendo/Creatures Inc./GAME FREAK Inc./The Pokémon Company and used here under fair use in a non-commercial, open-source project.
