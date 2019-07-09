# World of Warcraft AddOn

This project resembles my final project for my undergraduate degree. It implements an heuristic approach to the Travelling Salesman Problem, which remains unsolved due to the fact that it is NP-Complete. 

In short, given a set of towns which are connected by roads, a salesman wants to visit each town only once (and eventually return to his homecity). It is required to find such a path that minimizes the distance the salesman has to walk.

Using the World of Warcraft API which is made available by Blizzard, i extracted the coordinates of all currently available Quests (they are the Objectives) and tested different approaches to solve TSP. I have extended the problem by adding Time constraints (the average time it takes for a player to finish a quest) and Terrain constraints (some regions in-game are inaccessible to users, so the path between two Objectives can't always be straight)

Documentation is available in the .pdf file attached (language: Romanian)

# Running the Code

In order to run the code, the World of Warcraft game is required. The project is an AddOn, which is meant to be used in-game by the players. For details on how to install the AddOn, see the link below:

https://www.wowhead.com/addons-how-to-install-and-maintain#installing-installing-the-addon


