package;

import openfl.display.Sprite;
import openfl.Lib;

import com.auroratide.sandbox.*;

class Main extends Sprite {

	public function new() {
		super();
		
        var s = new MultilineTextfield();
        this.addChild(s);
	}

}