import processing.video.*;
Capture video;

//Vehicle v;
Vehicle[] setA = new Vehicle[1000];
PVector targetA;

Vehicle[] setB = new Vehicle[1000];
PVector targetB;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height, 60);
  video.start();
  
  noStroke();
  
  for(int i = 0; i < 1000; i++){
    setA[i] = new Vehicle(random(0, width), random(0, height));
  }
  
  for(int i = 0; i < 1000; i++){
    setB[i] = new Vehicle(random(0, width), random(0, height));
  }
  
  targetA = new PVector(width/2, height/2);
  targetB = new PVector(width/2, height/2);
  background(255);
}

void draw() {
 
  // background(0); 
  if(video.available()){
    video.read();
  }
  video.loadPixels();

  targetA.y = sin(millis() * 0.00075) * height/2 + height/2;
  targetA.x = cos(millis() * 0.00025) * width/2 + width/2;
  
  targetB = targetA.get();
  targetB.x = width - targetB.x;
  
//  fill(200);
//  ellipse(targetA.x, targetA.y, 10, 10);
//  
//  fill(200);
//  ellipse(targetB.x, targetB.y, 10, 10);

  // Call the appropriate steering behaviors for our agents
  for(Vehicle v: setA){
     v.seek(targetA);
      v.update();
      v.display();
  }
  
  for(Vehicle v: setB){
     v.seek(targetB);
      v.update();
      v.display();
  }
 
}

