# akinator

This is a little Akinator game that guesses popular marvel characters for android and ios using Bayes' theorem as base for its algorithm. 

## Getting Started

To run and change this project, you'll need to install [Flutter SDK](https://docs.flutter.dev/get-started/install) on your system. The SDK already comess with Dart SDK, so you won't need to install it separately. Then, you should install Flutter and Dart extensions for VSCode and any ios or android emulator. After that, go into VSCode, open the project folder, press "Select device" in the bottom right and choose a desired device.

<img width="1039" alt="Снимок экрана 2025-04-28 в 20 06 40" src="https://github.com/user-attachments/assets/c8b6ea64-0ba7-4575-9c1d-04aecc536144" />

Then, press "Run and Debug" to launch the app in the emulator. For a full tutorial on how to set up a Flutter environment, develop and launch Flutter apps, consider one of these tutorials: 
[Video](https://docs.flutter.dev/get-started/codelab). 
[Text](https://docs.flutter.dev/)

## Development process

The very first thing i did was searching for how the original Akinator works in the internet, and choosing the algorithm whhich best suits my skills. Since the Akinator team keeps their algorithm secret, all i could find was people's assumptions and suggestions, so i decided to find the most occuring trends among them and come up with my own algorithm. The main point in all of them was:

-**Akinator has a database which contains dozens of characters, each of which have a wide range of traits.**

There were a lot of assumptions regarding the logic of the akgorithm, from sofisticated statistics and confidence rates for each characers to decision trees and LLMs. Since i lack both skills to create a good decision tree model or to create convoluted statistic alforithms, i decided to use one of the most basic theorems in statistics - Bayes' theorem. The basic idea of ​​Bayes' theorem is simple and consists of the following:

Imagine that you have a statement - "A random person who has glasses is more likely to be a librarian than an athlete". The probability that the statement is true is equal to the following: 
| Number of examples where hypothesis is true |
|:--------------------------------------------:|
| Number of examples where hypothesis is true + Number of examples where hypothesis is false |

To generalize this example, we need to break the original statement into a hypothesis and evidence. The hypothesis is "A random person, based on the available evidence, is more likely to be a librarian than an athlete," and the evidence is "The person has glasses." Now, we can turn the example above into:
| Number of examples where hypothesis is true given the evidence |
|:--------------------------------------------------------------:|
| Number of examples where hypothesis is true given the evidence + Number of examples where hypothesis is false given the evidence (or just the number of examples which fit the evidence) |

Now that we know this idea, we can apply it to Akinator. Knowing that each character in the database has a certain set of traits like "has_a_mask: true, is_a_villain: false", we can use the already known data about the character as evidence, and all the other traits to form a claim.

Example:

Imagine that from the player's answers we know that the character has a mask and the character does not have a weapon. This is our evidence. Now, we can form a claim with this evidence for all the other traits in the database. For example, if the characters also have traits like "has_a_suit, uses_magic", then we can form two more claims:

"The character has a suit when given that he has a mask and does not have a weapon" and "The character uses magic when given that he has a mask and does not have a weapon".

Now, we can look at the number of characters in the database that match these claims, and calculate the probability that the claim is true, that is, the probability that the character has this or that trait.

Now, knowing this, we can choose which question to ask the player. I decided to ask the player a question that corresponds to the trait with the lowest probability of the hero to have, because if the answer to the question is "Yes", we will cut off the maximum number of heroes from the available answers.

Example:
The player answered that his character has the following traits: "has_a_suit" and "uses_magic". In the database, among the characters that match the player's given traits, the following traits are found in the following quantities:

"has_a_mask": 5 times

"uses_magic": 8 times

Since the trait that occurs less often is obviously less likely to occur, Akinator chooses this trait as a target and asks the player something like: "Does your character use magic?"
