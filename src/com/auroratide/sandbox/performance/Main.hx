package com.auroratide.sandbox.performance;

import com.auroratide.performance.PerformanceTest;

/**
 *  Main Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class Main {

/*  Constructor
 *  =========================================================================*/
    public function new() {
        run();
    }

/*  Public Methods
 *  =========================================================================*/
    public function run():Void {
        var tests = new PerformanceTest();
        tests.add(new ArrayAccessTest(8, 1048576));
        tests.add(new BinarySearchTest(8, 1048576));
        tests.add(new LinearSearchTest(8, 1048576));
        tests.add(new MergeSortTest(8, 1048576));
        tests.add(new InsertionSortTest(8, 1048576));
        tests.run();
        Sys.print(tests.reportAll());
    }
    
}