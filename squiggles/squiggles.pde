//Agent testAgent;
int MAXAGENTS = 500;
Agent[] testAgents = new Agent[MAXAGENTS];

void setup(){
  size(600, 600);
  
  for(int i = 0; i < MAXAGENTS; ++i){
    testAgents[i] = new Agent(5);
  }
  
  background(255);
}

void draw(){
  noStroke();
  fill(255, 255, 255, 0.5);
  rect(0, 0, width, height);
  for(int i = 0; i < MAXAGENTS; ++i){
    testAgents[i].update(millis());
    testAgents[i].display();
  }
}

color getRandomColor(){
  return color(int(random(255)), int(random(255)),int(random(255)));
}

class Agent{
  PVector lastLocation, location, velocity;
  float amplitude;
  color fill;
  
  Agent(int _amplitude){
    location = new PVector(random(0, width), random(0, height));
    velocity = new PVector(0, 0);
    amplitude = _amplitude;
    fill = getRandomColor();
  }
  
  void checkEdges(){
    //ensure that the particles remain on screen
    if(location.x > width || location.x < 0){
      velocity.x = -velocity.x;
    }
    if(location.y > height || location.y < 0){
      velocity.y = -velocity.y;
    }
  }
  
  void update(float timer){    
    
    lastLocation = location.get();
    
    velocity.x = random(-amplitude, amplitude);
    velocity.y = random(-amplitude, amplitude);
 checkEdges();   
    location.add(velocity);
  }
  
  void display(){
    stroke(fill);
    strokeWeight(PVector.dist(lastLocation, location)/10);
    line(lastLocation.x, lastLocation.y, location.x, location.y);
  }
}
