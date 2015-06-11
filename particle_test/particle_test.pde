import processing.opengl.*;

//make a point follow the mouse
int W = 800;
int H = 600;
int MAX_PARTICLES = 1000;

PVector mouse = new PVector(mouseX, mouseY);

Particle[] particles = new Particle[MAX_PARTICLES];

void setup(){
  size(W, H, OPENGL);
  for(int i = 0; i < particles.length; i++){
    particles[i] = new Particle();
  }
  
}

void draw(){
  background(0);
  stroke(255);
  updateMouseVector();
  for(int i = 0; i < particles.length; i++){
    particles[i].update();
    particles[i].display();    
  }
}

///print snippet
void keyPressed(){
  //println(keyCode);
  //keycode for 'p' = 80
  if(keyCode == 80){
    saveFrame();
  }
}

void saveFrame(){
  //get the name of the current sketch
  save(getClass().getName() + ".jpeg");
}

///end snippet


void updateMouseVector(){
  mouse.x = mouseX;
  mouse.y = mouseY;
}

class Particle{

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
    
  Particle(){
    location = new PVector(random(W), random(H));
    velocity= new PVector(0, 0);
    topspeed = int(random(4, 10));    
  }
  
  void update(){
    PVector dir = PVector.sub(mouse, location); //make vector pointing towards mouse
    dir.normalize(); //Normalize (divide by magnitude, convert to unit vector
    dir.mult(0.3); //Scale. This should be a constant
    acceleration = dir; //set to acceleration
    
    //motion
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void display(){
    point(location.x, location.y);
  }

}
