import gab.opencv.*;
import processing.video.*;

Movie video;
OpenCV opencv;

void setup() {
  size(720, 480);
  video = new Movie(this, "street.mov");
  opencv = new OpenCV(this, 720, 480);
  
  opencv.startBackgroundSubtraction(5, 3, 0.5);
  
  video.loop();
  video.play();
}

void draw() {
  image(video, 0, 0);  
  opencv.loadImage(video);
  
  opencv.updateBackground();
  
  opencv.dilate();
  opencv.erode();

//  noFill();
  fill(255, 0, 0);
//  strokeWeight(3);
noStroke();
  java.awt.Rectangle bb;
  for (Contour contour : opencv.findContours()) {
    bb = contour.getBoundingBox();
//    println(contour.getBoundingBox());
  if(bb.height * bb.width > 200){
    ellipse(bb.x + bb.width/2, bb.y + bb.height/2, 5, 5);
  }
    
//    contour.draw();
  }
}

void movieEvent(Movie m) {
  m.read();
}
