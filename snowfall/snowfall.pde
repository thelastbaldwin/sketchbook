int W = 400; //800/2
int H = 300; //600/2
int TOPSPEED = 5;
int MAX_PARTICLES = 2000;
int DIFF_THRESHOLD = 20;
int DIFF_WAIT = 50;
Particle[] particles = new Particle[MAX_PARTICLES];

PVector pPosition; //previous anchor position
PVector cPosition; //current anchor position
PVector uWind; //wind powered by user
Timer  posTimer;

void setup(){
  size(800, 600);
  noStroke();
    //initialize paticles
  for(int i = 0; i < particles.length; i++){
      particles[i] = new Particle(int(random(0, W)), //x
        int(random(0, H)), //y
        int(random(2, 50)),  //mass
        int(random(2, 8))); //size
    }
    
  pPosition = new PVector(mouseX, mouseY);
  cPosition = new PVector(mouseX, mouseY);
  uWind = new PVector(0, 0);
  
  posTimer = new Timer(DIFF_WAIT);
  posTimer.start();
}

void draw(){  
  background(50);
  fill(255);
  
  if(posTimer.isFinished()){
      shiftPositions();
      
      posTimer.reset();
      posTimer.start();
      if(abs(pPosition.x - cPosition.x) > DIFF_THRESHOLD){
        println("cPosition.x - pPosition.x = " + (cPosition.x - pPosition.x));
        uWind.x = cPosition.x - pPosition.x;
      }
  }
    
  for(int i = 0; i < particles.length; i++){
    particles[i].update();
    particles[i].display(); 
  }    
  uWind.x = 0; 
  
  //testing for over button
  if(overRect(int(cPosition.x), int(cPosition.y), 400, 400, 50, 50))
  {
    fill(255, 0, 0);
  }
  else{
    fill(255, 255, 0);
  }
  rect(400, 400, 50, 50);
}

void shiftPositions(){
  pPosition.x = cPosition.x;
  pPosition.y = cPosition.y;

  cPosition.x = mouseX;
  cPosition.y = mouseY;
}

boolean overRect(int x, int y, int rectX, int rectY, int width, int height){
  if(x >= rectX && x <= x+width && y > rectY && y <= y+height){
    return true;
  }else{
    return false;
  }
}

