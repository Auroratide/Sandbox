package com.auroratide.sandbox;

import haxe.io.Bytes;
import sys.io.File;

/**
 *  Steganography Class
 *  @author  Timothy Foster (tfAuroratide)
 * 
 *  Only works with BMP images
 */
class Steganography {
    public static inline var START = 54;
    
    public var inPath:String;
    public var outPath:String;
    
/*  Constructor
 *  =========================================================================*/
    public function new(inPath:String, outPath:String) {
        this.inPath = inPath;
        this.outPath = outPath;
    }
    
/*  Class Methods
 *  =========================================================================*/
    
 
/*  Public Methods
 *  =========================================================================*/
    public function embed(msg:String, stride = 1):Void {
        var img = getImageBytes();
        
        var mask:Int = ~((1 << stride) - 1);
        var msgData = Bytes.ofString(msg + String.fromCharCode(0));
        var imgIt = START;
        
        for (i in 0...msgData.length) {
            var char = msgData.get(i);
            var u = 8 - stride;
            while (u >= 0) {
                var imgByte = img.get(imgIt);
                var charBits = (char >> u) & ~mask;
                imgByte = (imgByte & mask) | charBits;
                img.set(imgIt, imgByte);
                u -= stride;
                if (++imgIt > img.length) {
                    trace("Warning: Image length exceeded");
                    return;
                }
            }
        }
        
        writeImageBytes(img);
    }

    public function extract(stride = 1):String {
        var img = getImageBytes();
        
        var mask:Int = (1 << stride) - 1;
        var imgIt = START;
        var msg = new StringBuf();
        
        var char = 1;
        while (imgIt < img.length && char > 0) {
            char = 0;
            var u = 8 - stride;
            while (imgIt < img.length && u >= 0) {
                var imgByte = img.get(imgIt);
                char |= (imgByte & mask) << u;
                u -= stride;
                ++imgIt;
            }
            msg.addChar(char);
        }
        
        return msg.toString();
    }

 
/*  Private Members
 *  =========================================================================*/
    
 
/*  Private Methods
 *  =========================================================================*/
    private function getImageBytes():Bytes {
        var f = File.read(this.inPath);
        var b = f.readAll();
        f.close();
        return b;
    }
    
    private function writeImageBytes(b:Bytes):Void {
        var f = File.write(this.outPath);
        f.write(b);
        f.flush();
        f.close();
    }
}