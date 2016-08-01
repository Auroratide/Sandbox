package com.auroratide.sandbox.performance;

/**
 *  ArrayAccessTest Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class ArrayAccessTest extends ArrayAlgorithmModule {

    override public function operation():Void {
        state = array[randomInt()];
    }
    
    override public function iterations():Int {
        return 1000000;
    }
    
    private var state:Int;
    
}