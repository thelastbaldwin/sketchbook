import processing.serial.*;

Serial port;
int patternIndex;
int NUM_PATTERNS = 4;
int PATTERN_WIDTH = 9, PATTERN_HEIGHT = 9;
PImage[] patterns = new PImage[NUM_PATTERNS];

void setup(){
  size(900, 900);
  String arduinoPort = Serial.list()[Serial.list().length - 1];
  port = new Serial(this, arduinoPort, 9600);
//  port.clear();
//  println(Serial.list());
 patternIndex = 0;
 noStroke();
 
 for(int i = 0; i < NUM_PATTERNS; i++){
   patterns[i] = loadImage("pattern" + (i + 1) + ".gif");
   patterns[i].loadPixels();
 }
}

void draw(){
  background(205);
  rect(width/2, height/2, 100, 100);
  
  for(int i = 0; i < PATTERN_WIDTH * PATTERN_HEIGHT; i++){
    square((i % PATTERN_WIDTH) * width/PATTERN_WIDTH, 
    (i / PATTERN_WIDTH) % PATTERN_WIDTH * height/PATTERN_HEIGHT, 
    width/PATTERN_WIDTH,
    patterns[patternIndex].pixels[i]);
  }
}

void keyPressed(){
  patternIndex = (patternIndex + 1) % patterns.length;
  println("***********");
  printAllColors(patterns[patternIndex].pixels);
}

void serialEvent(Serial p){
  int serialVal = p.read();
  if(serialVal == '1'){
    patternIndex = (patternIndex + 1) % patterns.length;
  }
}

void square(int x, int y, int size, color c){
  fill(c);
  rect(x, y, size, size);
}

void printAllColors(int[] colorVals){
  for(int i = 0; i < colorVals.length; ++i){
    printColor(colorVals[i]);
  }
}

void printColor(int colorVal){
  color c = color(colorVal);
  println(colorVal + ",");
//  println("[" + int(red(c)) + "," + int(green(c)) + "," + int(blue(c)) + "],");
}

