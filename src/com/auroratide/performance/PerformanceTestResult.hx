package com.auroratide.performance;

/**
 *  PerformanceTestResult Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class PerformanceTestResult {

/*  Constructor
 *  =========================================================================*/
    public function new() {
        resultsString = new StringBuf();
        resultsString.add("Input size\t\tIterations\t\tTotal time\t\tTime per op\n");
    }
 
/*  Public Methods
 *  =========================================================================*/
    public function add(inputSize:Int, iterations:Int, totalTime:Float):Void {
        resultsString.add(inputSize);
        resultsString.add("\t\t");
        resultsString.add(iterations);
        resultsString.add("\t\t");
        resultsString.add(totalTime);
        resultsString.add("\t\t");
        resultsString.add(totalTime / iterations);
        resultsString.add("\n");
    }
    
    public function toString():String {
        return resultsString.toString();
    }
 
/*  Private Members
 *  =========================================================================*/
    private var resultsString:StringBuf;

}