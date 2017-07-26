package com.auroratide.sandbox.grid;

/**
 *  LinkedListGrid Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class LinkedListGrid<T> implements Grid<T> {

/*  Constructor
 *  =========================================================================*/
    public function new(?defaultValue:T) {
        this.defaultValue = defaultValue;
        this.list = new Array<Node<T>>();
    }
 
/*  Public Methods
 *  =========================================================================*/
/**
 *  @inheritDoc
 */
    public function get(x:Int, y:Int):T {
        if (!isNodeCached(x, y)) {
            var node = find(x, y);
            if (node != null)
                cacheNode(node);
            else
                return defaultValue;
        }
        
        return cachedNode.elem;
    }
    
/**
 *  @inheritDoc
 */
    public function set(x:Int, y:Int, obj:T):Void {
        if (!isNodeCached(x, y)) {
            var node = find(x, y);
            if (node == null)
                node = createNode(x, y, obj);
            cacheNode(node);
        }
        
        cachedNode.elem = obj;
    }
        
/**
 *  @inheritDoc
 */
    public function remove(x:Int, y:Int):Void {
        if (isNodeCached(x, y)) {
            list.remove(cachedNode);
            cacheNode(null);
        }
        else {
            var node = find(x, y);
            if (node != null)
                list.remove(node);
        }
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
        for (node in list) {
            if (node.x < minX) minX = node.x;
            if (node.x > maxX) maxX = node.x;
            if (node.y < minY) minY = node.y;
            if (node.y > maxY) maxY = node.y;
        }
        
        return {minX: minX, minY: minY, maxX: maxX + 1, maxY: maxY + 1};
    }
        
/**
 *  @inheritDoc
 */
    public function memory():Int {
        return 12 * list.length;
    }
 
/*  Private Members
 *  =========================================================================*/
    private var defaultValue:T;
    private var list:Array<Node<T>>;
    
    private var cachedNode:Node<T>;
 
/*  Private Methods
 *  =========================================================================*/
    private function find(x:Int, y:Int):Node<T> {
        for (node in list)
            if (node.isCoord(x, y))
                return node;
        return null;
    }
 
    private function cacheNode(node:Node<T>):Void {
        cachedNode = node;
    }
    
    private function createNode(x:Int, y:Int, elem:T):Node<T> {
        var node = new Node<T>(x, y, elem);
        list.push(node);
        return node;
    }
    
    private function isNodeCached(x:Int, y:Int):Bool {
        return cachedNode != null && cachedNode.isCoord(x, y);
    }
}

private class Node<T> {
    public var x(default, null):Int;
    public var y(default, null):Int;
    public var elem:T;
    
    public function new(x:Int, y:Int, elem:T) {
        this.x = x;
        this.y = y;
        this.elem = elem;
    }
    
    public function isCoord(x:Int, y:Int):Bool {
        return this.x == x && this.y == y;
    }
}