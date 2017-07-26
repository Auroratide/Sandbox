package com.auroratide.sandbox.grid.test;

import haxe.Constraints.Constructible;

import com.auroratide.sandbox.grid.Grid;
import com.auroratide.performance.PerformanceModule;

/**
 *  RandomTest Class
 *  @author  Timothy Foster (tfAuroratide)
 */
@:generic class RandomAccessTest<T:(Constructible<Dynamic>, Grid<Int>)> extends PerformanceModule {

/*  Constructor
 *  =========================================================================*/
    public function new(lowerbound:Int, upperbound:Int, boundingBoxFactor:Float) {
        super(lowerbound, upperbound);
        this.boundingBoxFactor = boundingBoxFactor;
    }
 
/*  Public Methods
 *  =========================================================================*/
    override public function preOperation():Void {
        grid = new T(0);
        for (i in 0...currentSize())
            grid.set(randIntInBoundingBox(), randIntInBoundingBox(), 0xFFFFFF);
    }
    
    override public function operation():Void {
        state = grid.get(randIntInBoundingBox(), randIntInBoundingBox());
    }
    
    override public function iterations():Int {
        return Math.ceil(262144 / currentSize());
    }
    
    override public function postOperation():Void {
        trace('Completed: ${currentSize()}');
    }
 
/*  Private Members
 *  =========================================================================*/
    private var grid:T;
    private var boundingBoxFactor:Float;
    private var state:Int;
 
/*  Private Methods
 *  =========================================================================*/
    private function randIntInBoundingBox():Int {
        return Math.floor(Math.random() * currentSize() * boundingBoxFactor);
    }
}