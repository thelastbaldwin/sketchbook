class Ring{
  float opacity, size, speed;
  PVector location;

  
  Ring(){
    location = new PVector(int(random(width)), int(random(height)));
    opacity = random(100.0, 255.0);
    size = random(100.0);
    speed = 1.0;
  }
  
  Ring(int _x, int _y, float _opacity, float _size, float _speed){
    location = new PVector(_x, _y);
    opacity = _opacity;
    size = _size;
    speed = _speed;
  }
  
  Ring(float _x, float _y, float _opacity, float _size, float _speed){
    location = new PVector(_x, _y);
    opacity = _opacity;
    size = _size;
    speed = _speed;
  }
  
  boolean isFinished(){
    if(opacity * 3 <= 0.0){
      return true;
    }
    return false;
  }
  
  void update(){
    opacity -= speed;
    size += pow(speed, 2.25);
  }
  
  void display(){ 
    blendMode(ADD);
    tint(255, opacity*.15);
    image(texture, location.x, location.y, size, size);
  } 
}

int MAX_RINGS = 50;
ArrayList<Ring> rings;
OPC opc;
PImage texture;
color BGColor;

void setup(){
  size(800, 800, P3D);
  noFill();
  
  blendMode(ADD);
  imageMode(CENTER);
  
  texture = loadImage("ring.png");
  
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.ledGrid8x8(0, width/2, height/2, height / 16.0, 0, false);
  
//  BGColor = color(0, 78, 100);
  BGColor = color(0, 100, 100);
  
  rings = new ArrayList<Ring>();
}

void update(){  
  //remove items from array if they're finished
  for(int i= rings.size() - 1; i >= 0; i--){
    Ring ring = rings.get(i);
    ring.update(); 
    
    if(ring.isFinished()){
      rings.remove(i);
    }
  }
  
  //update bg
  colorMode(HSB);
  BGColor = color(hue(BGColor), saturation(BGColor), 105 + sin(millis() * .0005) * 15);
}

void draw(){
  update();
  
  
  background(BGColor);  
  
  colorMode(RGB);
  for(int i= rings.size() - 1; i >= 0; i--){
    Ring ring = rings.get(i);
    ring.display();
  }
}

void mouseMoved(){
  if(rings.size() < MAX_RINGS){
    //Ring(int _x, int _y, float _opacity, float _size, float _speed)
    rings.add(new Ring(mouseX, mouseY, 100.0, 50.0, 5.0));
  }
}
