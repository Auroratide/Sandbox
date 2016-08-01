package com.auroratide.sandbox.performance;

/**
 *  MergeSortTest Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class MergeSortTest extends ArrayAlgorithmModule {

    override public function operation():Void {
        state = mergeSort(array);
    //  ArraySort is a merge sort, but it sucks
    }
    
    override public function iterations():Int {
        return Math.ceil(131072.0 / currentSize());
    }
    
    private var state:Array<Int>;
    
    private function mergeSort(arr:Array<Int>):Array<Int> {
        var sortedArray = arr.map(function(a):Int {  return 0; });
        mergeSortStep(arr, sortedArray, 0, arr.length);
        return sortedArray;
    }
    
    private function mergeSortStep(orig:Array<Int>, sorted:Array<Int>, l:Int, r:Int):Void {
        if (r - l < 2)
            return;
        var middle = Math.floor((r + l) / 2);
        mergeSortStep(orig, sorted, l, middle);
        mergeSortStep(orig, sorted, middle, r);
        mergeSortMerge(orig, sorted, l, middle, r);
    }
    
    private function mergeSortMerge(orig:Array<Int>, sorted:Array<Int>, l:Int, mid:Int, r:Int):Void {
        var i = l;
        var j = mid;
        for (k in l...r) {
            if (i < mid && (j >= r || orig[i] <= orig[j]))
                sorted[k] = orig[i++];
            else
                sorted[k] = orig[j++];
        }
    }
    
}