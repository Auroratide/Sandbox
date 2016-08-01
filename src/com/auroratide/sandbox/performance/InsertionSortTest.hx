package com.auroratide.sandbox.performance;

/**
 *  InsertionSortTest Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class InsertionSortTest extends ArrayAlgorithmModule {

    override public function operation():Void {
        state = insertionSort(array);
    }
    
    override public function iterations():Int {
        return Math.ceil(8192.0 / currentSize());
    }
    
    private var state:Array<Int>;
    
    private function insertionSort(arr:Array<Int>):Array<Int> {
        var sorted = new Array<Int>();
        for (e in arr)
            sortedInsert(sorted, e);
        return sorted;
    }
    
    private function sortedInsert(arr:Array<Int>, n:Int):Void {
        var pos = 0;
        while (pos < arr.length && n < arr[pos])
            ++pos;
        arr.insert(pos, n);
    }
    
}