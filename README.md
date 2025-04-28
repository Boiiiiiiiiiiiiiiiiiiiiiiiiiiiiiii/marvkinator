# akinator

This is a little Akinator game that guesses popular marvel characters for android and ios using Bayes' theorem as base for its algorithm. 
Go to [this video](https://youtu.be/3HChkHzhJ0M) to see the demo

## Getting Started

To run and change this project, you'll need to install [Flutter SDK](https://docs.flutter.dev/get-started/install) on your system. The SDK already comess with Dart SDK, so you won't need to install it separately. Then, you should install Flutter and Dart extensions for VSCode and any ios or android emulator. After that, go into VSCode, open the project folder, press "Select device" in the bottom right and choose a desired device.

<img width="1039" alt="Снимок экрана 2025-04-28 в 20 06 40" src="https://github.com/user-attachments/assets/c8b6ea64-0ba7-4575-9c1d-04aecc536144" />

Then, press "Run and Debug" to launch the app in the emulator. For a full tutorial on how to set up a Flutter environment, develop and launch Flutter apps, consider one of these tutorials: 
[Video](https://docs.flutter.dev/get-started/codelab). 
[Text](https://docs.flutter.dev/)

To get the project apk to run on android devices, download the app-release.apk file from build/outputs/flutter-apk/app-release.apk.

## Development process

The very first thing i did was searching for how the original Akinator works in the internet, and choosing the algorithm whhich best suits my skills. Since the Akinator team keeps their algorithm secret, all i could find was people's assumptions and suggestions, so i decided to find the most occuring trends among them and come up with my own algorithm. The main point in all of them was:

-**Akinator has a database which contains dozens of characters, each of which have a wide range of traits.**

There were a lot of assumptions regarding the logic of the algorithm, from sofisticated statistics and confidence rates for each characers to decision trees and LLMs. Since i lack both skills and resources to create a good decision tree model or to create convoluted statistic alforithms, i decided to use one of the most basic theorems in statistics - Bayes' theorem. The basic idea of ​​Bayes' theorem is simple and consists of the following:

Imagine that you have a statement - "A random person who has glasses is more likely to be a librarian than an athlete". The probability that the statement is true is equal to the following: 
| Number of librarians with glasses |
|:--------------------------------------------:|
| Number of librarians with glasses + Number of athletes with glasses |

To generalize this example, we need to break the original statement into a hypothesis and evidence. The hypothesis is "A random person, based on the available evidence, is more likely to be a librarian than an athlete," and the evidence is "The person has glasses." Now, we can turn the example above into:

| Number of examples where hypothesis is true given the evidence |
|:--------------------------------------------------------------:|
| Number of examples where hypothesis is true given the evidence + Number of examples where hypothesis is false given the evidence (or just the number of examples which fit the evidence) |

Now that we know this idea, we can apply it to Akinator. Knowing that each character in the database has a certain set of traits like "has_a_mask: true, is_a_villain: false", we can use the already known data about the character as evidence, and all the other traits to form a statement.

Example:

Imagine that from the player's answers we know that the character has a mask and the character does not have a weapon. This is our evidence. Now, we can form a statement with this evidence for all the other traits in the database. For example, if the characters also have traits like _"has_a_suit, uses_magic"_, then we can form two more statements:

_"The character has a suit when given that he has a mask and does not have a weapon"_ and _"The character uses magic when given that he has a mask and does not have a weapon"_.

Now, we can look at the number of characters in the database that match these statements, and calculate the probability that the statement is true, that is, the probability that the character has this or that trait.

Now, knowing this, we can choose which question to ask the player. I decided to ask the player a question that corresponds to the trait with the lowest probability of the hero to have, because if the answer to the question is "Yes", we will cut off the maximum number of heroes from the available answers.

Example:
The player answered that his character has the following traits: "has_a_suit" and "uses_magic". In the database, among the characters that match the player's given traits, the following traits are found in the following quantities:

"has_a_mask": 5 times

"uses_magic": 8 times

Since the trait that occurs less often is obviously less likely to occur, Akinator chooses this trait as a target and asks the player something like: "Does your character use magic?"

Now that we know this idea, we can apply it to Akinator. Knowing that each character in the database has a certain set of traits like "has_a_mask: true, is_a_villain: false", we can use the already known data about the character as evidence, and all the other traits to form a statement.

Example:

Imagine that from the player's answers we know that the character has a mask and the character does not have a weapon. This is our evidence. Now, we can form a statement with this evidence for all the other traits in the database. For example, if the characters also have traits like "has_a_suit, uses_magic", then we can form two more statements:

"The character has a suit when given that he has a mask and does not have a weapon" and "The character uses magic when given that he has a mask and does not have a weapon".

Now, we can look at the number of characters in the database that match these statements, and calculate the probability that the statement is true, that is, the probability that the character has this or that trait.

Now, knowing this, we can choose which question to ask the player. I decided to ask the player a question that corresponds to the trait with the lowest probability of the hero to have, because if the answer to the question is "Yes", we will cut off the maximum number of heroes from the available answers.

Example:
The player answered that his character has the following traits: "has_a_suit" and "uses_magic". In the database, among the characters that match the player's given traits, the following traits are found in the following quantities:

"has_a_mask": 5 times

"uses_magic": 8 times

Since the trait that occurs less often is obviously less likely to occur, Akinator chooses this trait as a target and asks the player something like: "Does your character use magic?"

Now, after receiving the answer to the question, Akinator updates the certificate and repeats the above process until there is one character left in the database that matches the certificate. If the player answers "I don't know", the akinator does not update the certificate. Instead, it asks a question that matches the trait that is second most likely to appear. If the player answers "I don't know" again, it asks the question for the third place, and so on. This can lead to the player answering "I don't know" to all the questions available to the akinator, after which the akinator will give a page with dissatisfied text and ask the player to choose another character.

After I came up with this (most likely already created before me) algorithm, I just had to implement it in the application.

Naturally, there are cases when no character fits the description, in which case the akinator gives a page where it says that it does not know characters that fit the description. Since this does not pose any big problems from a technical point of view, there is nothing to talk about the implementation process.

## Compromises

Since my algorithm is quite simple (and I couldn't come up with a solution to this problem), I had to resort to one rather critical compromise. Since we calculate how many times a particular trait appears among all heroes that fit the current description to choose the next question, the algorithm itself can only accept the values ​​"the character definitely has the trait" or "the character definitely doesn't have the trait", which is why I had to make it so that Akinator evaluates the questions "yes" and "probably", and, accordingly, "no" and "probably not" - the same. If the player answers "Probably not" to the question "Does the character have a connection to Asgard?", then Akinator evaluates this as "The character is **definitely** not connected to Asgard", which may lead to inaccurate guesses when the database expands.

## Known errors and problems

-The database is very tiny. As of now, there are only 25 available characters to guess, and each character has 50~ traits. This leads to the problems like Akinator being able to "guess" the character by one question. For example, there's only one charater who is teenager in the db-Spider-man, so if Akinator happens to choose to ask if the character is a teenager as his first question and the answer happens to be "Yes", Akinator will "guess" the Spider-man instantly. 

-The app does not handle cases where there are two characters with exact same traits left. I'm здфттштп to add a екфше - frequency of choosing this character, so that Akinator would give out the character with greater frequency in such cases

-The parts of the app which interact with the database are slow. 

## Stack
-Flutter: frontend and logic

-MySQL: Database type

-PHP: For api.

-Clever cloud: database and api deployment. 

Flutter was chosen because Akinator does not require complicated UI, so making it on flutter saves a lot of time that would be spent on creating the UI and UX. Flutter also lets easily build the app for web, ios and android, so that i can test and deploy the app on any platforms.

Both MySQL and PHP was chosen because hese are the technologies i have the most experience with thanks to my school, and because they were convenient for the implementation of the task.

Clever cloud was chosen because it is free, lets easily deploy a MySQL database, start a web service based on php, provides enough storage space and does not go to "sleep" due to inactivity.
