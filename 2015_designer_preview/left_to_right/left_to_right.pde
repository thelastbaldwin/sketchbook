int MAX_PARTICLES = 5000;
Particle particles[] = new Particle[MAX_PARTICLES];

void setup(){
  size(800, 800, OPENGL);
  noStroke();
  
  for(int i = 0; i < MAX_PARTICLES; i++){
    particles[i] = new Particle(random(width), random(height), random(0.1, 3.0));
  }
}

void draw(){
  fill(255, 5);
  rect(0, 0, width, height);
  
  for(Particle p: particles){
    p.update();
    p.display();
  } 
}

class Particle{
  PVector position;
  PVector velocity;
  int size;
  float maxSpeed;
  
  Particle(float xPos, float yPos, float speed){
    position = new PVector(xPos, yPos);
    velocity = new PVector(-speed, 0);
    size = int(random(4, 16));
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
    fill(0);
    point(position.x, position.y);
    rect(position.x, position.y, size, 2);
  }
} 
