package com.auroratide.performance;

/**
 *  PerformanceModule Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class PerformanceModule {

/*  Constructor
 *  =========================================================================*/
    public function new(lowerBound:Int = 1, upperBound:Int = 1) {
        this.lowerBound = lowerBound;
        this.upperBound = upperBound;
        reset();
    }
 
/*  Public Methods
 *  =========================================================================*/
    public function preOperation():Void {}
    public function operation():Void {}
    public function postOperation():Void {}
    
    public function currentSize():Int {
        return this.current;
    }
    
    public function iterations():Int {
        return 1;
    }
    
    public function next():Void {
        this.current *= 2;
    }
    
    public function done():Bool {
        return this.current > this.upperBound;
    }
    
    public function reset():Void {
        this.current = this.lowerBound;
    }
 
/*  Private Members
 *  =========================================================================*/
    private var lowerBound:Int;
    private var upperBound:Int;
    private var current:Int;
 
}