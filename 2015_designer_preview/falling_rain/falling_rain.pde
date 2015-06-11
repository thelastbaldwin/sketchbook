import processing.video.*;

PShader maskShader;
PGraphics maskImage;
Movie movie;

int MAX_PARTICLES = 5000;
Particle particles[] = new Particle[MAX_PARTICLES];

void setup(){
  size(1200, 400, OPENGL);
  stroke(50, 0, 255);
//  strokeWeight(10);
  
  for(int i = 0; i < MAX_PARTICLES; i++){
    particles[i] = new Particle(random(width), random(height), random(0.1, 1.0), i);
  }
  
  background(0);
  
  maskShader = loadShader("mask.glsl");
  maskImage = createGraphics(displayWidth, displayHeight, OPENGL);
  
  maskShader.set("mask", maskImage);
  
  movie = new Movie(this, "ink.mov");
  movie.loop();
}

void draw(){
  maskImage.beginDraw();
  maskImage.image(movie, 0, 0, 1920, 1080);
  maskImage.endDraw();
  
  noFill();
  strokeWeight(10);
  for(Particle p: particles){
    p.update();
    p.display();
  } 

//  drawOutput(0, 0, width, height);
  filter(maskShader);
}

void movieEvent(Movie m) {
  m.read();
}

class Particle{
  PVector position, pOld;
  PVector velocity;
  int size;
  int index;
  float maxSpeed;
  color c;
  
  Particle(float xPos, float yPos, float speed, int i){
    position = new PVector(xPos, yPos);
    pOld = position.get();   
    velocity = new PVector(0, 0);
    size = 1;
    maxSpeed = speed;
    index = i;
    c = getRandomColor();
  }
  
  void update(){
//    float angle = position.heading() + 2 * noise(millis()/1000 + index);
    float angle = position.heading() + map(noise(millis()/1000 + index), 0, 1, 0, PI/2);
    
    PVector shift = PVector.fromAngle(angle);
    velocity.add(shift);
    velocity.limit(maxSpeed);
    pOld.set(position);
    position.add(velocity);
    checkEdges();
  }
  
  void checkEdges(){
    if(position.x < 0 || position.x > width || position.y > height || position.y < 0){
      position.x = random(width);
      position.y = 0;
      pOld.set(position);
    }
  }
  
  void display(){
    stroke(c);
    line(pOld.x, pOld.y, position.x, position.y);
  }
} 

color getRandomColor(){
  return color(int(random(255)), int(random(255)), int(random(255)));
}

void drawOutput(float x, float y, float w, float h) {
  pushMatrix();
  translate(x, y);
  noStroke();
  beginShape(QUAD);
  // Although we are not associating a texture to 
  // this shape, the uv coordinates will be stored
  // anyways so they can be used in the fragment 
  // shader to access the destination and source
  // images.
  vertex(0, 0, 0, 0);
  vertex(w, 0, 1, 0);
  vertex(w, h, 1, 1);
  vertex(0, h, 0, 1);
  endShape();
  popMatrix();  
}
