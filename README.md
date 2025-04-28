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

-**Akinator has a database which contains dozens of characters, each of which have a wide range of traits. **

There were a lot of assumptions regarding the logic of the akgorithm, from sofisticated statistics and confidence rates for each characers to decision trees and LLMs. Since i lack both skills to create a good decision tree model or to create convoluted statistic alforithms, i decided to use one of the most basic theorems in statistics - Bayes' theorem. The basic idea of ​​Bayes' theorem is simple and consists of the following:
Imagine that you have a statement - "A random person who has glasses is more likely to be a librarian than an athlete". The probability that the statement is true is equal to the following: 
\[
\frac{\text{Number of librarians with glasses}}{\text{Number of librarians with glasses} + \text{Number of athletes with glasses}}
\]

To generalize this example, we need to break the original statement into a hypothesis and evidence. The hypothesis is "A random person, based on the available evidence, is more likely to be a librarian than an athlete," and the evidence is "The person has glasses." Now, we can turn the example above into:
\[
\frac{\text{Number of examples where hypothesis is true given the evidence}}{\text{Number of examples where hypothesis is true given the evidence} + \text{Number of examples where hypothesis is false given the evidence} \text{(or just the number of example which fit the evidence)}}
\]

