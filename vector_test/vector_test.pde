Particle p;

PVector mouse;

float n; //previous value of noise

void setup(){
  n = 0.1;
  size(600, 600);
  p = new Particle();
  mouse = new PVector(mouseX, mouseY);
}

void draw(){
  //update the mouse position
  mouse.x = mouseX;
  mouse.y = mouseY;
  
  background(211);
  
  //base to measure hit detection on
  fill(0);
  ellipse(200, 400, 50, 50);
  p.update();
  p.display();

  n += 0.1;
  println(noise(n));
  
}

void keyPressed(){
   if(key == 'b'){
     //do something!
   }
}

class Particle{
  PVector location;
  PVector acceleration;
  PVector velocity;
  int radius;
  
  int topspeed;
  
  Particle(){
    radius = 150;
    location = new PVector(int(random(width/2)), int(random(height/2)));
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.01);
    topspeed = 10;
  }
  
  void update(){
      
    
    //direction
    PVector dir = new PVector(mouse.x - location.x, mouse.y-location.y);
        
    //normalize    
    dir.normalize();
    
    //scale
    dir.mult(0.1);
    
    //accelerate
    acceleration = dir;
    
    if(isHitting()){
      velocity.mult(-1);
    }
    
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    
  }
  
  //need a method to detect if it's hitting something
  boolean isHitting(){
     if (dist(location.x, location.y, 200, 400) < radius-50){
       println("hit");
       return true;
     }
     return false;
  }
  
  void display(){
     fill(255);
     ellipse(location.x, location.y, radius, radius);
  }
}
