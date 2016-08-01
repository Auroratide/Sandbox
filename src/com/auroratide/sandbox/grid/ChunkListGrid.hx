package com.auroratide.color_conways.grid;

import com.auroratide.color_conways.util.TrackableMemory;

/**
 *  Grid Class
 *  @author  Timothy Foster (tfAuroratide)
 * 
 *  Represents an infinite grid.  Arbitrary coordinates can be selected within
 *  the bounds of Int, and the Grid will always tray to allocate space to
 *  ensure the coordinate exists.
 */
class ChunkListGrid<T> implements Grid<T> implements TrackableMemory {
    
/*  Constructor
 *  =========================================================================*/
/**
 *  Creates a new Grid
 *  @param defaultValue The value "empty" cells should have.  `null` by default.
 */
    public function new(?defaultValue:T) {
        this.defaultValue = defaultValue;
        this.chunks = new Array<GridChunk<T>>();
        this.chunkCache = new Array<GridChunk<T>>();
    }
 
/*  Public Methods
 *  =========================================================================*/
/**
 *  @inheritDoc
 */
    public function get(x:Int, y:Int):T {
        if(chunkExistsFor(x, y))
            return getChunkContaining(x, y).get(x, y);
        else
            return defaultValue;
    }
    
/**
 *  @inheritDoc
 */
    public function set(x:Int, y:Int, obj:T):Void {
        if(!chunkExistsFor(x, y))
            createChunkContaining(x, y);
        getChunkContaining(x, y).set(x, y, obj);
    }
        
/**
 *  @inheritDoc
 */
    public function remove(x:Int, y:Int):Void {
        if(chunkExistsFor(x, y))
            set(x, y, defaultValue);
    }
        
/**
 *  @inheritDoc
 */
    public function exists(x:Int, y:Int):Bool
        return get(x, y) != defaultValue;
    
/**
 *  @inheritDoc
 */
    public function bounds():{minX:Int, minY:Int, maxX:Int, maxY:Int} {
        var minX = 2147483647;
        var minY = 2147483647;
        var maxX = -2147483647;
        var maxY = -2147483647;
        for (chunk in chunks)
            for (i in 0...GridChunk.CHUNK_WIDTH) for (j in 0...GridChunk.CHUNK_WIDTH) {
                var x = chunk.x + i;
                var y = chunk.y + j;
                if (chunk.get(x, y) != defaultValue) {
                    if (x < minX) minX = x;
                    if (x > maxX) maxX = x;
                    if (y < minY) minY = y;
                    if (y > maxY) maxY = y;
                }
            }
        return {minX: minX, minY: minY, maxX: maxX + 1, maxY: maxY + 1};
    }
    
/**
 *  @inheritDoc
 */
    public function memory():Int {
        return 4 * GridChunk.CHUNK_WIDTH * GridChunk.CHUNK_WIDTH * chunks.length;
    }
 
/*  Private Members
 *  =========================================================================*/
/** The default value of a cell.  Can be null. */
    private var defaultValue:T;
 
/** Contains all chunks */
    private var chunks:Array<GridChunk<T>>;
    
/**
 *  A cache is used to quickly load chunks if neighboring coordinates are accessed.
 *  It is set to contain at most log2(N) chunks, where N is chunks.length.  This
 *  is monitored by the cacheChunk() method.
 */
    private var chunkCache:Array<GridChunk<T>>;
 
/*  Private Methods
 *  =========================================================================*/
/**
 *  @private
 *  Returns whether a chunk exists for the coordinate.  Caches the chunk if found.
 *  @param x
 *  @param y
 *  @return
 */
    private function chunkExistsFor(x:Int, y:Int):Bool {
        return getChunkContaining(x, y) != null;
    }
 
/**
 *  @private
 *  Retrieves a chunk which contains (x, y), caching it if it exists.  Returns null if no such chunk is found.
 *  @param x
 *  @param y
 *  @return
 */
    private function getChunkContaining(x:Int, y:Int):GridChunk<T> {
        for (chunk in chunkCache)
            if (chunk.contains(x, y))
                return chunk;
                
        for (chunk in chunks) {
            if (chunk.contains(x, y)) {
                cacheChunk(chunk);
                return chunk;
            }
        }
        
        return null;
    }
    
/**
 *  @private
 *  Creates a new chunk containing the coordinate (x, y).  Caches the chunk as well.
 *  @param x
 *  @param y
 *  @return The newly created chunk
 */
    private function createChunkContaining(x:Int, y:Int):GridChunk<T> {
    //  The expression (((a % b) + b) % b) returns a mod b, not just the remainder of a / b
        var chunk = new GridChunk<T>(x - (((x % GridChunk.CHUNK_WIDTH) + GridChunk.CHUNK_WIDTH) % GridChunk.CHUNK_WIDTH), y - (((y % GridChunk.CHUNK_WIDTH) + GridChunk.CHUNK_WIDTH) % GridChunk.CHUNK_WIDTH), this.defaultValue);
        chunks.push(chunk);
        cacheChunk(chunk);
        return chunk;
    }
    
/**
 *  @private
 *  Puts the chunk into the cache
 *  @param chunk
 */
    private function cacheChunk(chunk:GridChunk<T>):Void {
        chunkCache.unshift(chunk);
        var limit = Math.floor(Math.log(chunks.length) / 0.6931471805599453094); // ln(2)
        if (limit < 2)
            limit = 2;
        if (chunkCache.length > limit)
            chunkCache.pop();
    }
}

/**
 *  The Grid class represents an infinite grid using a list of GridChunks.
 *  A GridChunk is simply an array of Bools representing a
 *  CHUNK_WIDTH x CHUNK_WIDTH square of coordinates.
 * 
 *  We use this over two principle alternatives.  We could have used a single
 *  giant Array, but this runs into two problems.  First, it is extremely
 *  space inefficient.  Even if the Grid contains just two live points that
 *  are millions of units away, millions of units would need to be allocated.
 *  Second, reallocation needs to occur every time a coordinate outside the
 *  current space is accessed.  This takes O(n) time, where n is the
 *  current number of usable coordinates.
 * 
 *  We could also have used a linked list of some kind.  There are a couple
 *  of ways to try this, but it has complications with coordinate access.
 *  Though space efficient, accessing a coordinate's live state takes O(n)
 *  time.
 * 
 *  Instead, we maintain a list of chunks, and the chunks don't even need
 *  to be connected to one another.  Now, two live units separated by
 *  millions of blocks only require the amount of cells created by two chunks.
 *  Additionally, access of a single coordinate is achieved by traversing
 *  only the list of chunks, and therefore access takes O(n/w^2) time, where
 *  w is the width of a chunk.
 * 
 *  We actually make things even faster by using a cache.  Knowing this
 *  Grid will be used for Conway's Game of Life, we note that coordinates
 *  are almost always accessed next to each other, in other words accessing
 *  the same chunk.  Storing the few last accessed chunks means that on
 *  average, rather than needing O(n) time, access is in O(log n).
 */
private class GridChunk<T> {
    public static inline var CHUNK_WIDTH = 16;
    
//  These coordinates are the bottom left cell
    public var x(default, null):Int;
    public var y(default, null):Int;
    
/*  Constructor
 *  =========================================================================*/
    public function new(x:Int, y:Int, defaultValue:T) {
        this.x = x;
        this.y = y;
        this.cells = new Array<T>();
        for (i in 0...(CHUNK_WIDTH * CHUNK_WIDTH))
            this.cells.push(defaultValue);
    }
    
/*  Public Methods
 *  =========================================================================*/
    public function contains(x:Int, y:Int):Bool {
        return this.x <= x && x < this.x + CHUNK_WIDTH &&
               this.y <= y && y < this.y + CHUNK_WIDTH;
    }
    
    public function get(x:Int, y:Int):T {
        return cells[coordsToPosition(x, y)];
    }
    
    public function set(x:Int, y:Int, obj:T):Void {
        cells[coordsToPosition(x, y)] = obj;
    }
 
/*  Private Members
 *  =========================================================================*/
    private var cells:Array<T>;
    
/*  Private Methods
 *  =========================================================================*/
    private function coordsToPosition(x:Int, y:Int):Int {
        return (x - this.x) + CHUNK_WIDTH * (y - this.y);
    }
}