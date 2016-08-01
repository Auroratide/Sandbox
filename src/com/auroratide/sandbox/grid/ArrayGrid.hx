package com.auroratide.sandbox.grid;

/**
 *  ArrayGrid Class
 * 
 *  This class is optimal around (0, 0).
 *  @author  Timothy Foster (tfAuroratide)
 */
class ArrayGrid<T> implements Grid<T> {

/*  Constructor
 *  =========================================================================*/
    public function new(?defaultValue:T) {
        this.defaultValue = defaultValue;
        allocateNewArray(0, 0, 1, 1); // an array of size 1
    }
 
/*  Public Methods
 *  =========================================================================*/
/**
 *  @inheritDoc
 */
    public function get(x:Int, y:Int):T {
        if(inBounds(x, y))
            return unsafeGet(x, y);
        else
            return defaultValue; // when reading, no need to allocate space
    }
    
/**
 *  @inheritDoc
 */
    public function set(x:Int, y:Int, obj:T):Void {
        if (!inBounds(x, y)) {
            var newMinX = minX;
            var newMaxX = maxX;
            var newMinY = minY;
            var newMaxY = maxY;
            if (x < minX)
                newMinX = 2 * x - 2;
            else if (x >= maxX)
                newMaxX = 2 * x + 2;
            if (y < minY)
                newMinY = 2 * y - 2;
            else if (y >= maxY)
                newMaxY = 2 * y + 2;
            
            allocateNewArray(newMinX, newMinY, newMaxX, newMaxY);
        }
        unsafeSet(x, y, obj);
    }
        
/**
 *  @inheritDoc
 */
    public function remove(x:Int, y:Int):Void {
        set(x, y, defaultValue);
    }
        
/**
 *  @inheritDoc
 */
    public function exists(x:Int, y:Int):Bool {
        return get(x, y) != defaultValue;
    }
    
/**
 *  @inheritDoc
 */
    public function bounds():{minX:Int, minY:Int, maxX:Int, maxY:Int} {
        return {
            minX: this.minX,
            minY: this.minY,
            maxX: this.maxX,
            maxY: this.maxY
        };
    }
    
/**
 *  @inheritDoc
 */
    public function memory():Int {
        return 4 * cells.length;
    }
 
/*  Private Members
 *  =========================================================================*/
    private var defaultValue:T;
    private var cells:Array<T>;
    
//  Inclusive Bounds
    private var minX:Int;
    private var minY:Int;
    
//  Exclusive Bounds
    private var maxX:Int;
    private var maxY:Int;
 
/*  Private Methods
 *  =========================================================================*/
/**
 *  @private
 *  Allocates a new array to accommodate the given dimensions and copies over the values from the old array such
 *  that their coordinates are preserved.
 *  @param newMinX
 *  @param newMinY
 *  @param newMaxX
 *  @param newMaxY
 */
    private function allocateNewArray(newMinX:Int, newMinY:Int, newMaxX:Int, newMaxY:Int):Void {
        var newCells = new Array<T>();
        for (y in newMinY...newMaxY) for (x in newMinX...newMaxX) {
            if (inBounds(x, y))
                newCells.push(unsafeGet(x, y));
            else
                newCells.push(defaultValue);
        }
        cells = newCells;
        minX = newMinX;
        maxX = newMaxX;
        minY = newMinY;
        maxY = newMaxY;
    }
    
/**
 *  @private
 *  Retrieves the value at (x, y) from the array.  Does not do any bound checking.
 *  @param x
 *  @param y
 *  @return
 */
    private function unsafeGet(x:Int, y:Int):T 
        return cells[coordsToIndex(x, y)];
    
/**
 *  @private
 *  Puts the given object into cell (x, y).  Does not do any bound checking.
 *  @param x
 *  @param y
 *  @param obj
 */
    private function unsafeSet(x:Int, y:Int, obj:T):Void 
        cells[coordsToIndex(x, y)] = obj;
    
/**
 *  @private
 *  Returns true if the given cell is represented in the current array.
 *  @param x
 *  @param y
 *  @return true if cell is represented in the array, false otherwise
 */
    private inline function inBounds(x:Int, y:Int):Bool 
        return minX <= x && x < maxX && minY <= y && y < maxY;
    
/**
 *  @private
 *  Converts a coordinate pair into an index for the array.
 *  @param x
 *  @param y
 *  @return
 */
    private inline function coordsToIndex(x:Int, y:Int):Int 
        return (x - minX) + (maxX - minX) * (y - minY);
}