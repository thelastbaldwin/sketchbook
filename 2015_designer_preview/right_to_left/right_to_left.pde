import controlP5.*;
ControlP5 cp5;

PShader RGBShader;

int MAX_PARTICLES = 5000;
Particle particles[] = new Particle[MAX_PARTICLES];

float angle = 0;
float amount = 0.005;

void setup(){
  size(1200, 400, OPENGL);
  noStroke();
  
  for(int i = 0; i < MAX_PARTICLES; i++){
    particles[i] = new Particle(random(width), random(height), random(0.1, 3.0));
  }
  
  RGBShader = loadShader("RGBShift.glsl");
  textureWrap(REPEAT);
  
  cp5 = new ControlP5(this);
  Group controls = cp5.addGroup("controls").setPosition(10, 10).setWidth(260).setBackgroundColor(color(0, 200)).setBackgroundHeight(60).activateEvent(true).setLabel("controls");
  cp5.addSlider("angle").setMin(0.0).setMax(TWO_PI).setValue(angle).setPosition(10, 20).setSize(180, 9).setGroup(controls);
  cp5.addSlider("amount").setMin(0.0001).setMax(0.5).setValue(amount).setPosition(10, 40).setSize(180, 9).setGroup(controls);
}

void draw(){
//  fill(255, 150);
//  rect(0, 0, width, height);
background(0);
  
  for(Particle p: particles){
    p.update();
    p.display();
  } 
  
  RGBShader.set("angle", angle);
  RGBShader.set("amount", amount);
  filter(RGBShader);
}

class Particle{
  PVector position;
  PVector velocity;
  int size;
  float maxSpeed;
  
  Particle(float xPos, float yPos, float speed){
    position = new PVector(xPos, yPos);
    velocity = new PVector(-speed, 0);
    size = int(random(4, 24));
    maxSpeed = speed;
  }
  
  void update(){
//    PVector vShift = new PVector(random(-2, 2), 0);
    position.add(velocity);
//    position.add(vShift);
    checkEdges();
  }
  
  void checkEdges(){
    if(position.x + size < 0){
      position.x = width;
//      position.y = random(height);
    }
  }
  
  void display(){
    fill(255);
    point(position.x, position.y);
    rect(position.x, position.y, size, 2);
  }
} 
