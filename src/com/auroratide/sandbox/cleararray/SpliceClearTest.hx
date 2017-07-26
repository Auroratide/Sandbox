package com.auroratide.sandbox.cleararray;

class SpliceClearTest extends ClearArrayModule {

    override public function clear():Void {
        array.splice(0, array.length);
    }

}
