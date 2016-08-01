package com.auroratide.sandbox.performance;

/**
 *  LinearSearchTest Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class LinearSearchTest extends ArrayAlgorithmModule {
    
    override public function operation():Void {
        state = search(randomInt());
    }
    
    override public function iterations():Int {
        return Math.floor(4194304 / currentSize());
    }
    
//  This is needed to prevent compiler optimizations
    private var state:Bool;
    
    private function search(n:Int):Bool {
        for (i in array) if (i == n)
            return true;
        return false;
    }
    
}