package com.auroratide.sandbox.cleararray;

class LengthClearTest extends ClearArrayModule {

    override public function clear():Void {
        untyped array.length = 0;
    }

}
