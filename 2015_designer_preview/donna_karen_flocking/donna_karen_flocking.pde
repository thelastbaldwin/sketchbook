/**
 * Based on Flocking by Daniel Schiffman
*/

import controlP5.*;
ControlP5 cp5;

Flock flock;
PShader dotMatrixShader;
PShader blurShader;

float spacing = 12.0;
float size = 6.0;
float blur = 60.0;
float h = 0;

void setup() {
  size(1200, 400, OPENGL);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 500; i++) {
    flock.addBoid(new Boid(width/2,height/2));
  }
  
  blurShader = loadShader("blur.glsl"); 
  dotMatrixShader = loadShader("dot_matrix.glsl");
  dotMatrixShader.set("resolution", float(width), float(height));
  
  cp5 = new ControlP5(this);
  Group controls = cp5.addGroup("controls").setPosition(10, 10).setWidth(260).setBackgroundColor(color(0, 200)).setBackgroundHeight(80).activateEvent(true).setLabel("controls");
  cp5.addSlider("spacing").setMin(0.0001).setMax(100.0).setValue(spacing).setPosition(10, 20).setSize(180, 9).setGroup(controls);
  cp5.addSlider("size").setMin(0.0001).setMax(100.0).setValue(size).setPosition(10, 40).setSize(180, 9).setGroup(controls);
  cp5.addSlider("blur").setMin(0.0001).setMax(100.0).setValue(blur).setPosition(10, 60).setSize(180, 9).setGroup(controls);
}

void draw() {
  background(0);
  flock.run();
  
  dotMatrixShader.set("spacing", spacing);
  dotMatrixShader.set("size", size);
  dotMatrixShader.set("blur", blur);

//  filter(blurShader);
  filter(dotMatrixShader);
}
