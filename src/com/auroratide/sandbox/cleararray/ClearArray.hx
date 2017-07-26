package com.auroratide.sandbox.cleararray;

import com.auroratide.performance.PerformanceTest;

class ClearArray {

    public function new() {
        run();
    }

    public function run():Void {
        var tests = new PerformanceTest();
        tests.add(new SpliceClearTest(8, 1048576));
        tests.add(new LengthClearTest(8, 1048576));
        tests.add(new AssignmentClearTest(8, 1048576));

        tests.run();
        Sys.print(tests.reportAll());
    }

}
