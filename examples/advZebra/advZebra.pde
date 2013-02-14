
// zebra wrapper is a lightweight wrapper for grabbing qrCodes
// it is based upon code developed by andrew odewahn CODEBOX @ MAKE :

// http://blog.makezine.com/2011/03/02/codebox-use-qr-codes-in-processing/

import processing.video.*;

Capture cam; //Set up the camera

int WIDTH = 640;
int HEIGHT = 480;

PVector[] points;


Zebra zebra;
// Grabs the image file    

void setup() {
  
  size(640, 480);
  cam = new Capture(this, WIDTH, HEIGHT);
  cam.start();
  
  zebra = new Zebra();
  point = new PVector[4]; // there are 4 corners to a point
  
}
 

void draw() {
  
  if (cam.available() == true) {
    cam.read();    
    image(cam, 0,0);

    // note we do this inside cam.available
    // so it only fires when a camera frame is ready
    // note also that zebra needs to have the capture object passed to it!
    
    if (zebra.update( cam ) ) {
      
       // zebra.update returns true if you get a tag
       // so we only print this if there is a tag
       
       String s = zebra.getText(); 
       println("The tag says:  " + s); 
       
       
       // only use the next function with tags on O'Rielly books -- it is very specific.
       //zebra.showOff();
       
       
    }
    
    
  }
}
