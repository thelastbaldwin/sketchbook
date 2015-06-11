float AVELOCITY = 0.05; //this will be shared amongst instances
float AMPLITUDE;
int OCOUNT = 41;
float OFFSET = .08;

Oscillator[] oscillators = new Oscillator[OCOUNT];

void setup(){
  AMPLITUDE = height * 2;
  size(800,400);
  for(int i = 0; i < OCOUNT; i++){
    oscillators[i] = new Oscillator(i*20, 0, 20);
    oscillators[i].setAngle(i * OFFSET);
  }
}

void draw(){
  background(201);
  
  fill(255, 50);
  for(int i = 0; i < OCOUNT; i++){
    oscillators[i].update();
    oscillators[i].display();
  }
}

class Oscillator{
  //would be cool to draw a line from x, y to start location
  int size;
  float angle, x, y;
  
  Oscillator(int _x, int _y, int _size){
    x = _x;
    y = _y;
    size = _size;
    angle = 0.0;
  }
  
  void update(){
    angle += AVELOCITY;
    y = AMPLITUDE * cos(angle);    
  }
  
  void display(){
    pushMatrix();
    translate(0, height/2);
    line(x, 0, x, y); 
    ellipse(x, y, size, size);
    popMatrix();
  }
  
  void setAngle(float a){
    angle = a;
  }
  
  float getAngle(){
    return angle;
  }
}

