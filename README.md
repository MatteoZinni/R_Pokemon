
![](Pokémon_images/R_Pokémon_images_logo.png)

# DATA SCIENCE PRACTISING USING POKEMON

## Introducing Pokémon
Pokémon are creatures of all shapes and sizes who live in the wild or alongside humans. The concept of the Pokémon comes from the hobby - quite common in Japan - to collect insects as stated by their creator Satoshi Tajiri. Pokèmon can be wild or tamed by a person called "Trainer". A Pokèmon trainer goals are tipically to complete the Pokédex by collecting all of the available Pokémon species found in the fictional region and to train a team of powerful Pokémon from those he has caught. Just like other lifeforms, Pokémon grow, level up and become more experienced and even, on occasion, evolve into stronger Pokémon.

## The dataset
The dataset contains 801 Pokèmon from 7 generations (1996-2019) and 45 variables. Features refer only to [Pokèmon video games](https://github.com/https://en.wikipedia.org/wiki/Pok%C3%A9mon_(video_game_series)) and not to other products such as [Pokèmon GO](https://github.com/https://en.wikipedia.org/wiki/Pok%C3%A9mon_Go) or [trading card game](https://github.com/https://en.wikipedia.org/wiki/Pok%C3%A9mon_Trading_Card_Game). The original version is available for free download at [Kaggle.com](//github.com/https:https://www.kaggle.com/rounakbanik/pokemon).

## Data preparation
Data preparation included the following steps to improve the aesthetic apprearence of the dataset:

### Features editing
* Make the first header letter capital 
* Encoding ```Classification``` column to proprerly display accent 
* Edit ```Type_1``` and ```Type_2``` to displasy as capital the first letter
* Edit ```Generation``` name to display roman numeral
* Edit ```Ability``` column to obtain one column for each

### Data cleaning: missing data
We need first to check the consistency of the data to ensure that there are no missing values: if some missing are present we cand decide to use our knowledge to replace them or simply not to consider entries with missing values. The goal of this phase is to that data are consistent. Since often data have been genereated by somebody else caution is a good option in this early stage: any error occurred in this phase will propagate to all the analys.

* Check for NAs
* Replace missing data

With only 20 Pokémon with no ```Height``` nor ```Weight``` the dataset seems to be a fairly complete data set. 

### Data engineering 
Since each Pokèmon generation belong to a different region a new feature (Region) have been creating ```assign_region``` custom function that is store in the local project folder. The function makes a double check on the Pokedex_Number number and on the Generation to which the Pokémon belongs to assign the proper region name.




#### License
The source icons are (c) Nintendo/Creatures Inc./GAME FREAK Inc./The Pokémon Company and used here under fair use in a non-commercial, open-source project.
