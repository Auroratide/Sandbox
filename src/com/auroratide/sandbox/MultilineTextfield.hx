package com.auroratide.sandbox;

import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldType;

/**
 *  MultilineTextfield Class
 *  @author  Andy_Woods
 *  http://community.openfl.org/t/textfield-multiline-wordwrap-and-maxchars-for-dom-target-seems-broken/7699
 */
class MultilineTextfield extends Sprite {

/*  Constructor
 *  =========================================================================*/
    public function new() {
        super();
		
		var tf = new TextField();
		tf.text = duplicate('multiline = false, wordWrap = false, INPUT', 10);
		tf.type = TextFieldType.INPUT;
		tf.background = true;
		tf.backgroundColor = 0xffff00;
		tf.maxChars = 10;
		tf.multiline = false;
		tf.wordWrap = false;
		tf.width = 200;
		tf.height = 50;
		this.addChild(tf);
		tf.y = 100;
		tf.x = 200;
    }

/*  Private Methods
 *  =========================================================================*/
    private function duplicate(str:String, i:Int) {
		var arr:Array<String> = [];
		while (--i > 0) {
			arr.push(str);
		}
		return arr.join(", ");
	}
}