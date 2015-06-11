import processing.video.*;

Capture cam;
int NUM_ACROSS = 10, 
NUM_DOWN = 5, 
WIDTH = 1920, 
HEIGHT = 1080, 
THRESHOLD = 127,
NUM_COLORS = 6;

int camWidth, 
camHeight;

ColorTriad[] colorTriads = new ColorTriad[NUM_COLORS];

void setup() {
  size(WIDTH, HEIGHT);
  //cameras will only capture at 30fps. This prevents *some* flicker
//  frameRate(30);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[3]);
    cam.start();     
  } 
  
  camWidth = WIDTH/NUM_ACROSS;
  camHeight = HEIGHT/NUM_DOWN;
   
   shuffleColors(colorTriads);
}

void draw() {
  background(0);
  pushMatrix();
  
  //flip canvas horizontally
  scale(-1.0, 1.0);
  translate(-WIDTH, 0);
  
  if (cam.available() == true) {
    cam.read();
    
    PImage stillImage = cam.get();
    stillImage.resize(camWidth, camHeight);
    PImage stillImageCopy = stillImage;

   for(int column = 0; column < NUM_ACROSS; column++){
     for(int row = 0; row < NUM_DOWN; row++){
        stillImageCopy = colorPolarize(stillImage, 85, 127, colorTriads[(column + row) % NUM_COLORS]);
        image(stillImageCopy, column * camWidth, row * camHeight);
     }
   }
  }
  popMatrix();
}

//handle keypress
void keyPressed(){
  if(key == 's'){
    saveImage();
  }
  if(key == 'c'){
    shuffleColors(colorTriads);
  }
  println(key + " was pressed");
}

void shuffleColors(ColorTriad[] colorTriads){
  for(int i = 0; i < colorTriads.length; i++){
     colorTriads[i] = new ColorTriad(randomColor(), randomColor(), randomColor());
   }
}

//saveImage
void saveImage () {
  String filename = frame.getTitle() + timeStamp() + ".jpg";
  save(filename);
  println(filename + " was saved");
}

String timeStamp(){
  return year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
}


color randomColor(){
  color random = color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
  return random;
}

PImage colorPolarize(PImage source, int threshold, ColorPair cPair){
  PImage destination = source.get();
  
   for (int x = 0; x < source.width; x++) {
    for (int y = 0; y < source.height; y++ ) {
      int loc = x + y*source.width;
      // Test the brightness against the threshold
      if (brightness(source.pixels[loc]) > threshold) {
        destination.pixels[loc]  = cPair.first(); 
      }  else {
        destination.pixels[loc]  = cPair.second(); 
      }
    }
  }
  
  return destination;
}

PImage colorPolarize(PImage source, int lowThreshold, int highThreshold, ColorTriad cTriad){
  PImage destination = source.get();
 
   for (int x = 0; x < source.width; x++) {
    for (int y = 0; y < source.height; y++ ) {
      int loc = x + y*source.width;
      int brightness = int(brightness(destination.pixels[loc]));
      if(brightness < lowThreshold){
        destination.pixels[loc]  = cTriad.first(); 
      }else if(brightness >= lowThreshold && brightness <= highThreshold){
        destination.pixels[loc] = cTriad.second();
      }else{
        destination.pixels[loc] = cTriad.third();
      }
    }
  }
  
  return destination; 
}




