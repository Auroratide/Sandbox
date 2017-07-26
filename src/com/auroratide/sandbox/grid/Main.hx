package com.auroratide.sandbox.grid;

import com.auroratide.performance.PerformanceTest;
import com.auroratide.sandbox.grid.test.RandomAccessTest;

/**
 *  Main Class
 *  @author  Timothy Foster (tfAuroratide)
 */
class Main {

    public function new() {
        var tests = new PerformanceTest();
        tests.add(new RandomAccessTest<ChunkListGrid<Int>>(8, 4096, 1));
        tests.add(new RandomAccessTest<ChunkListGrid<Int>>(8, 4096, 0.5));
        tests.add(new RandomAccessTest<ChunkListGrid<Int>>(8, 4096, 0.25));
        tests.run();
        Sys.print(tests.reportAll());
    }
    
}