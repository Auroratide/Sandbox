package com.auroratide.sandbox.performance;

/**
 *  BinarySearchTest Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class BinarySearchTest extends ArrayAlgorithmModule {
    
    override public function preOperation():Void {
        super.preOperation();
        array.sort(function(a, b) {  return a < b ? -1 : 1; });
    }

    override public function operation():Void {
        state = binarySearch(randomInt());
    }
    
    override public function iterations():Int {
        return 100000;
    }
    
    private var state:Bool;
    
    private function binarySearch(n:Int):Bool {
        var min = 0;
        var max = array.length - 1;
        var midpoint = -1;

        while (min < max) {
            midpoint = Math.floor((min + max) / 2);
            if (array[midpoint] == n)
                return true;
            else if (array[midpoint] > n)
                max = midpoint - 1;
            else
                min = midpoint + 1;
        }
        
        return false;
    }
    
}