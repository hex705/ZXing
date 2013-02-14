import com.google.zxing.BinaryBitmap;
import java.awt.image.BufferedImage;
import processing.video.*; 

class Zebra {
  
com.google.zxing.Reader reader; // = new com.google.zxing.qrcode.QRCodeReader();
Result result;


PImage cover;  //This will have the cover image
String lastISBNAcquired = "";  //This is the last ISBN we acquired


  Zebra(){
     reader = new com.google.zxing.qrcode.QRCodeReader();
     println("added one zebra to the herd");
  }
  



boolean update(Capture theImage){
   boolean gotTag = false;
   
   try {  
         // Now test to see if it has a QR code embedded in it
         LuminanceSource source = new BufferedImageLuminanceSource( (BufferedImage) theImage.getImage() );
         BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));

         result = reader.decode(bitmap); 
         
         gotTag = true;
      } catch (Exception e) {
 //        println(e.toString()); 
         result = null;
      }
      
    return gotTag;
     
} // end update

String getText(){
      if ( result != null) {
       return result.getText();
      } else {
        return "Empty";
      }
 } // end GetZebraString

ResultPoint[] getPoints() {
  
  
  
}


void showOff(){
       //Once we get the results, we can do some display
       if (result.getText() != null) { 
         
          println(result.getText());
          ResultPoint[] points = result.getResultPoints();
          //Draw some ellipses on at the control points
          for (int i = 0; i < points.length; i++) {
            fill(#ff8c00);
            ellipse(points[i].getX(), points[i].getY(), 20,20);
          }
          
          // add here
          String[] parts = splitTokens(result.getText(),"/,-");
          println("parts length " + parts.length + "  last part " + parts[parts.length-2]);
     
          //Now fetch the book cover, if it is found
          if (!result.getText().equals(lastISBNAcquired)) {
             String url = "http://covers.oreilly.com/images/" + parts[parts.length-2] + "/cat.gif";
             try {
                cover = loadImage(url,"gif");
                lastISBNAcquired = result.getText();
             } catch (Exception e) {
               cover = null;
             }
          }
          //Superimpose the cover on the image
          if (cover != null) {
            image(cover, points[1].getX(), points[1].getY());
          } // end if 
          
       } // end if result
} //end showoff


 
} //end Zebra class

