package com.auroratide.sandbox.cleararray;

class PopClearTest extends ClearArrayModule {

    override public function clear():Void {
        while (array.length > 0)
            array.pop();
    }

}
