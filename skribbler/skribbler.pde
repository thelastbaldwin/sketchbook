import processing.video.*;
Capture video;

int MAX_SKRIBBLERS = 500;

Skribbler[] TS = new Skribbler[MAX_SKRIBBLERS];

void setup(){
  size(640, 480);
  video = new Capture(this, width, height, 60);
  video.start();
  noFill();

  for(int i = 0; i < MAX_SKRIBBLERS; i++){
    TS[i] = new Skribbler();
  }
}

void draw(){
  if(video.available()){
    video.read();
  }
  video.loadPixels();
  for(int i = 0; i < MAX_SKRIBBLERS; i++){
    TS[i].display();
  }
}

class Skribbler{
  int x, y, pointCount, curvePointX, curvePointY;
  float diffusion;
  
  Skribbler(){
    x = (int)random(width);
    y = (int)random(height);
    pointCount = 2;
    curvePointX = 0;
    curvePointY = 0;
    diffusion = random(5, 15);
  }
  
  void display(){ 
     
    
    for(int j=0; j <= mouseX/50; j++){
      int pixelIndex = ((video.width-1-x) + y*video.width);
       
     color c = video.pixels[pixelIndex];
     
     float saturation = constrain(saturation(c) * 2.0, 0, 255);
     colorMode(HSB, 255);
     c = color(hue(c), saturation, brightness(c) * 1.2);
     
     strokeWeight(hue(c)/50);
     stroke(c, 100);

      
     beginShape();
     curveVertex(x, y);
     curveVertex(x, y);
     for(int i = 0; i < pointCount; i++){
       int rx = (int)random(-diffusion, diffusion);
       curvePointX = constrain(x+rx, 0, width-1);
       int ry = (int)random(-diffusion, diffusion);
       curvePointY = constrain(y+ry, 0, height-1);
       curveVertex(curvePointX, curvePointY);
     }
     
     curveVertex(curvePointX, curvePointY);
     endShape();
     
     x = curvePointX;
     y = curvePointY;
    }
  }
}
