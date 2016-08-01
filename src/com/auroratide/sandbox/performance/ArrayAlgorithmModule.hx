package com.auroratide.sandbox.performance;

import com.auroratide.performance.PerformanceModule;

/**
 *  ArrayAlgorithmModule Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class ArrayAlgorithmModule extends PerformanceModule {

/*  Public Methods
 *  =========================================================================*/
    override public function preOperation():Void {
        array = new Array<Int>();
        for (i in 0...currentSize())
            array.push(randomInt());
    }
    
    override public function postOperation():Void {
        trace('Completed ${currentSize()}');
    }
 
/*  Private Members
 *  =========================================================================*/
    private var array:Array<Int>;
    
    private function randomInt():Int {
        return Math.floor(Math.random() * currentSize());
    }
    
}