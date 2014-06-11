//
//  STClassifier.swift
//  
//
//  Created by Samuel Turner on 11/06/2014.
//
//

import Foundation

protocol STClassifierClass {
    var type:String{get}
    func getVector() ->Array<Double>
    
}

class STClassifier<classType> {
    var trainingSet = STClassifierClass[]()
    
    // Given some object, classify it based on the training set
    func classify(c:STClassifierClass, n: Int) -> String {
        var vectors = Array<Double>[]()     // A list of all the vectors
        
        // Build vectors
        for t in trainingSet {
            vectors.append(t.getVector())
        }
        
        // Find closest neighbours
        var testVect = [24.0, 11.0]
        var closest:Array<Dictionary<String, Any>> = getClosestNeighbours(n, vectors: vectors, tVect: c.getVector())
        
        return getClassificationFromClosestVectors(closest)
    }
    
    func getClassificationFromClosestVectors(c:Array<Dictionary<String, Any>>) -> String {
        return c[0]["type"] as String
    }
    
    func getClosestNeighbours(n: Int, vectors:Array<Array<Double>>, tVect:Array<Double>) ->Array<Dictionary<String, Any>> {
        var o = Array<Dictionary<String, Any>>()
        
        var i = 0;
        
        for v in vectors {
            // Get the distance between this and the test vector
            v
            tVect
            var dist = getDistance(tVect, v2: v)
            
            var l : Dictionary<String,Any> = [
                "vector": v,
                "distance": dist,
                "type": trainingSet[i].type
            ]
            
            o.append(l)
            i++;
        }
        
        o.sort({$1["distance"] as Double > $0["distance"] as Double})
        return Array(o[0..n])
    }
    
    // Get the distance between two vectors
    func getDistance(v1:Array<Double>, v2:Array<Double>) -> Double {
        var t : Double = 0.0
        
        for i in 0...v1.count-1 {
            var diff = v1[i] - v2[i]    // minus
            t += (diff * diff)
        }
        
        return sqrt(t)
    }
    
    // Given some examples, add them to the training set
    func addTrainingExamples(examples:STClassifierClass...) {
        for example in examples {
            trainingSet.append(example);
        }
    }
    
    // Build an array of all the classes we can choose from in the training set
    func getClassesForTrainingSet() -> String[] {
        var classes = String[]()
        for train in trainingSet {
            if isUnique(train, classes: classes) {
                classes.append(train.type)
            }
        }
        return classes
    }
    
    // Given an object and all the classes so far, is this one unique?
    func isUnique(train:STClassifierClass, classes:String[]) -> Bool {
        for c in classes {
            if (c == train.type) {
                return false
            }
        }
        return true
    }
}

