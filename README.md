# STClassifier

STClassifier is an implementation of [K Nearest Neighbour](http://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm) written in Swift. 

**This is still pretty rough - it needs more error checking, comments, and a testing framework needs to be written!**

### Getting Started

Simply download the zip file and copy `STClassifier.swift` into your project and you're good to go!

### Usage

After you've imported `STClassifier.swift` into your project, you'll need to do a few things to get going:

1. The class you want to be able to classify must conform to the `STClassifierClass` protocol. It must have `type` as a class variable and it must implement the `getVector() -> Array<Double>` method.

2. Create a new classifier with `STClassifier<STClassifierClass>()` and add some training examples with `func addTrainingExamples examples:STClassifierClass...)`.

3. Create a new example with an empty `type` and pass it to `func classify(c:STClassifierClass) -> String` to get the predicted class.

If you get stuck, check out the example XCode project. A good way to play around is to copy the code into an XCode playground!




