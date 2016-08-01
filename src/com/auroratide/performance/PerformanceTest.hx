package com.auroratide.performance;

import haxe.Timer;

/**
 *  PerformanceTest Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class PerformanceTest {

/*  Constructor
 *  =========================================================================*/
    public function new() {
        this.modules = new Array<PerformanceModule>();
        this.results = new Map<PerformanceModule, PerformanceTestResult>();
    }
 
/*  Public Methods
 *  =========================================================================*/
    public function add(module:PerformanceModule):Void {
        this.modules.push(module);
        this.results.set(module, null);
    }
    
    public function run():Void {
        for (module in modules)
            this.results.set(module, testModule(module));
    }
    
    public function report(module:PerformanceModule):String {
        var buf = new StringBuf();
        buf.add(Type.getClassName(Type.getClass(module)));
        buf.add("\n");
        if (results.exists(module))
            buf.add(results[module]);
        else
            buf.add("Test was not run");
        
        return buf.toString();
    }
    
    public function reportAll():String {
        var buf = new StringBuf();
        for (module in modules) {
            buf.add(report(module));
            buf.add("\n\n");
        }
        return buf.toString();
    }
 
/*  Private Members
 *  =========================================================================*/
    private var modules:Array<PerformanceModule>;
    private var results:Map<PerformanceModule, PerformanceTestResult>;
 
/*  Private Methods
 *  =========================================================================*/
    private function testModule(module:PerformanceModule):PerformanceTestResult {
        var result = new PerformanceTestResult();
        module.reset();
        while (!module.done()) {
            module.preOperation();
            var time = timeOperation(module);
            module.postOperation();
            result.add(module.currentSize(), module.iterations(), time);
            module.next();
        }
        return result;
    }
    
    private function timeOperation(module:PerformanceModule):Float {
        var iterations = module.iterations();
        var before = Timer.stamp();
        for (it in 0...iterations)
            module.operation();
        return Timer.stamp() - before;
    }
}