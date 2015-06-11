import controlP5.*;
ControlP5 cp5;

int pointCount = 3200;
int freqX = 93;
int freqY = 98;
int freqZ = 95;
float phi = 0; // radial offset
float angle = 0.5;
float amplitude = 600;


PVector[] points = new PVector[0];

void setup(){
  size(600, 600, OPENGL);
  noFill();
  stroke(255);
  
  cp5 = new ControlP5(this);
  Group controls = cp5.addGroup("controls").setPosition(10, 10).setWidth(260).setBackgroundColor(color(0, 200)).setBackgroundHeight(100).activateEvent(true).setLabel("controls");
  cp5.addSlider("freqX").setMin(1).setMax(100).setValue(freqX).setPosition(10, 20).setSize(180, 9).setGroup(controls);
  cp5.addSlider("freqY").setMin(1).setMax(100).setValue(freqY).setPosition(10, 40).setSize(180, 9).setGroup(controls);
  cp5.addSlider("freqZ").setMin(1).setMax(100).setValue(freqZ).setPosition(10, 60).setSize(180, 9).setGroup(controls);
  cp5.addSlider("amplitude").setMin(0.0001).setMax(width * 1.2).setValue(amplitude).setPosition(10, 80).setSize(180, 9).setGroup(controls);
//  cp5.addSlider("phi").setMin(0).setMax(360).setValue(phi).setPosition(10, 80).setSize(180, 9).setGroup(controls); 
}

void draw(){
  fill(0, 50);
  rect(0, 0, width, height);
  noFill();
  
  phi += 0.004;
  float x, y, z, angle;
  pushMatrix();
  translate(width/2, height/2);
  rotate(phi, 1, 1, 1);
  beginShape();
  for(int i = 0; i < pointCount; i++){
    angle = map(i, 0, pointCount, 0, TWO_PI);
//    x = sin(angle * freqX + radians(phi))  * cos(angle * freqX + radians(phi))  * noise(angle * freqX + radians(phi))* amplitude;
//    y = sin(angle * freqY) * cos(angle * freqY) * noise(angle * freqY)  * amplitude;
//    z = sin(angle * freqZ) * cos(angle * freqZ) * noise(angle * freqZ)  * amplitude;
    
    x = sin(angle * freqX)  * cos(angle * freqX ) * amplitude;
    y = sin(angle * freqY) * cos(angle * freqY) * amplitude;
    z = sin(angle * freqZ) * cos(angle * freqZ) * amplitude;
    vertex(x, y, z);
  } 
  endShape(); 
  popMatrix();
}


