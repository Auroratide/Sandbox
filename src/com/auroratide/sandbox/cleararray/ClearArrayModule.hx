package com.auroratide.sandbox.cleararray;

import com.auroratide.performance.PerformanceModule;

class ClearArrayModule extends PerformanceModule {

    private var array:Array<Int>;

    public function clear():Void {}

    override public function preOperation():Void {
        array = new Array<Int>();
        for (i in 0...currentSize())
            array.push(randomInt());
    }

    override public function operation():Void {
        clear();
    }

    override public function iterations():Int {
        return 1000000;
    }

}
