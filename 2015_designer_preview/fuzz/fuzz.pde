int MAX_PARTICLES = 5000;
Particle particles[] = new Particle[MAX_PARTICLES];

PShader rectToPolar;

void setup(){
  size(1200, 400, OPENGL);
  noStroke();
  
  for(int i = 0; i < MAX_PARTICLES; i++){
    particles[i] = new Particle(random(width), random(height), random(0.1, 0.3));
  }
  
  rectToPolar = loadShader("rect_to_polar.glsl"); 
  rectToPolar.set("resolution", float(width), float(height));
  rectToPolar.set("center", width/2.0, height/2.0);
}

void draw(){
  fill(0, 15);
  rect(0, 0, width, height);
  
  for(Particle p: particles){
    p.update();
    p.display();
  } 
  
  float w = width/2 + cos(millis() * .0001) * width/2;
  float h = height/2 + sin(millis() * .0004) * height/2;
  rectToPolar.set("center", w, h);
  filter(rectToPolar);
}

color getRandomColor(){
  return color(int(random(255)), int(random(255)), int(random(255)));
}


class Particle{
  PVector position;
  PVector velocity;
  color fillColor;
  int size;
  float maxSpeed;
  
  Particle(float xPos, float yPos, float speed){
    position = new PVector(xPos, yPos);
    velocity = new PVector(0, -speed);
    size = int(random(2, 4));
    maxSpeed = speed;
    
    fillColor = getRandomColor();
  }
  
  void update(){
//    PVector vShift = new PVector(random(-2, 2), 0);
    position.add(velocity);
//    position.add(vShift);
    checkEdges();
  }
  
  void checkEdges(){
    if(position.y + size < 0){
      position.y = height;
      position.x = random(width);
    }
    if(position.x + size < 0){
      position.x = width;
//      position.y = random(height);
    }
  }
  
  void display(){
    fill(fillColor);
    point(position.x, position.y);
    rect(position.x, position.y, size, size);
  }
} 
