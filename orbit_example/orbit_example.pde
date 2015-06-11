//make a point orbit around the origin
int W = 400;
int H = 400;
float counter = 0.0;
float xPos;
float yPos;
float speed = 0.15;
int radius = W/6;

void setup(){
  size(W, H);
  frameRate(30);
}

void draw(){
  
  fill(0, 0, 0, 50);
  rect(0, 0, W, H);
  
  //origin
  fill(0);
  ellipse(W/2, H/2, 10, 3);
  
  
  //orbiter
  fill(255);
    ellipse(W/2 + radius * cos(counter), H/2 + radius * sin(counter) , 10, 10);
  
  counter += speed;
}
