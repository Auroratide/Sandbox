package com.auroratide.color_conways.grid;

/**
 * @author Timothy Foster (tfAuroratide)
 */
interface Grid<T> {
    
/**
 *  Returns the value stored in cell (x, y)
 *  @param x
 *  @param y
 *  @return The value in the cell.  Returns the default value if nothing exists there.
 */
    function get(x:Int, y:Int):T;
    
/**
 *  Assigns an element to cell (x, y)
 *  @param x
 *  @param y
 */
    function set(x:Int, y:Int, elem:T):Void;
    
/**
 *  Removes the element from cell (x, y).  Essentially the same as setting it to the default value.
 *
 *  Call get() first if you need to retrieve the value of the cell.
 *  @param x
 *  @param y
 */
    function remove(x:Int, y:Int):Void;
    
/**
 *  Returns whether a value exists in cell (x, y).  Essentially the same as checking for a default value.
 *  @param x
 *  @param y
 *  @return true if a non-default item exists in the cell, false otherwise
 */
    function exists(x:Int, y:Int):Bool;
    
/**
 *  Returns a bounding box containing all non-default cells. Inclusive on the lowerbound, exclusive on the upper bound.
 *  @return An object resembling a rectangle.
 */
    function bounds():{minX:Int, minY:Int, maxX:Int, maxY:Int};
}