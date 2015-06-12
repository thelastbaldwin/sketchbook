//import controlP5.*;
//ControlP5 cp5;

PShader RGBShader;

Ring testRing;
int MAX_RINGS = 100;
ArrayList<Ring> rings;

float angle = 0;
float amount = 0.005;

void setup(){
  size(1200, 400, OPENGL);
  noFill();
  
  rings = new ArrayList<Ring>();
  for(int i = 0; i < MAX_RINGS; ++i){
    rings.add(new Ring());
  }
  
  RGBShader = loadShader("RGBShift.glsl");
  textureWrap(REPEAT);
  
//  cp5 = new ControlP5(this);
//  Group controls = cp5.addGroup("controls").setPosition(10, 10).setWidth(260).setBackgroundColor(color(0, 200)).setBackgroundHeight(60).activateEvent(true).setLabel("controls");
//  cp5.addSlider("angle").setMin(0.0).setMax(TWO_PI).setValue(angle).setPosition(10, 20).setSize(180, 9).setGroup(controls);
//  cp5.addSlider("amount").setMin(0.0001).setMax(0.5).setValue(amount).setPosition(10, 40).setSize(180, 9).setGroup(controls);
}

void update(){  
  //remove items from array if they're finished
  for(int i= rings.size() - 1; i >= 0; i--){
    Ring ring = rings.get(i);
    ring.update(); 
    boolean[] bounds = ring.checkBounds();
    //add new rings if they're touching the top, left, bottom,
    //or right edges
    
    //top    
    if(ring.edges[0] == false && bounds[0] == true){
      ring.edges[0] = true;
      Ring topMirror = new Ring(ring.location.x, -ring.location.y, ring.opacity, ring.size, ring.speed);
      topMirror.edges[0] = true; //do not "re-reflect" on the top
      rings.add(topMirror);
    }
    //left
    if(ring.edges[1] == false && bounds[1] == true){
      ring.edges[1] = true;
      Ring leftMirror = new Ring(-ring.location.x, ring.location.y, ring.opacity, ring.size, ring.speed);
      leftMirror.edges[1] = true; //do not "re-reflect" on the left
      rings.add(leftMirror);
    }
    //bottom
    if(ring.edges[2] == false && bounds[2] == true){
      ring.edges[2] = true;
      Ring bottomMirror = new Ring(ring.location.x, 2 * height - ring.location.y, ring.opacity, ring.size, ring.speed);
      bottomMirror.edges[2] = true; //do not "re-reflect" on the right
      rings.add(bottomMirror);
    }
    //right
    if(ring.edges[3] == false && bounds[3] == true){
      ring.edges[3] = true;
      Ring rightMirror = new Ring(2 * width - ring.location.x, ring.location.y, ring.opacity, ring.size, ring.speed);
      rightMirror.edges[3] = true; //do not "re-reflect" on the bottom
      rings.add(rightMirror);
    }
    
    if(ring.isFinished()){
      rings.remove(i);
    }
  }
  
  //refill to max size
  while(rings.size() < MAX_RINGS){
    rings.add(new Ring());
  }
}

void draw(){
  update();
  
  background(0, 0, 0);  
  
//  testRing.update();
//  testRing.display();
//  println(testRing.opacity);

  for(int i= rings.size() - 1; i >= 0; i--){
    Ring ring = rings.get(i);
    ring.display();
  }
  
//  if(angle < TWO_PI){
//    angle += 0.05;
//  }else{
//    angle = 0;
//  }
  
  amount = 0.001 + sin(millis() * .001) * 0.005;
  RGBShader.set("angle", angle);
  RGBShader.set("amount", amount);
  filter(RGBShader);
}

class Ring{
  float opacity, size, speed;
  PVector location;
  
  //top, left, bottom, right
  boolean[] edges;
  
  Ring(){
    location = new PVector(int(random(width)), int(random(height)));
    opacity = random(10.0, 255.0);
    size = 5.0;
    speed = random(0.5, 2.0);
    edges = checkBounds();
  }
  
  Ring(int _x, int _y, float _opacity, float _size, float _speed){
    location = new PVector(_x, _y);
    opacity = _opacity;
    size = _size;
    speed = _speed;
    edges = checkBounds();
  }
  
  Ring(float _x, float _y, float _opacity, float _size, float _speed){
    location = new PVector(_x, _y);
    opacity = _opacity;
    size = _size;
    speed = _speed;
    edges = checkBounds();
  }
  
  boolean[] checkBounds(){
    boolean[] edges = {false, false, false, false};
    
    //top    
    if(this.location.y - this.size/2.0 <= 0){
      edges[0] = true;
    }
    //left
    if(this.location.x - this.size/2.0 <=0){
      edges[1] = true;
    }
    //bottom
    if(this.location.y + this.size/2.0 >= height){
      edges[2] = true;
    }
    //right
    if(this.location.x + this.size/2.0 >= width){
      edges[3] = true;
    }
    
    return edges;
  }
  
  boolean isFinished(){
    if(opacity * 3 <= 0.0){
      return true;
    }
    return false;
  }
  
  void update(){
    opacity -= speed;
    size += speed * 2;
  }
  
  void display(){ 
    strokeWeight(4);
    stroke(255, opacity);
    ellipse(location.x, location.y, size, size);
  } 
}
