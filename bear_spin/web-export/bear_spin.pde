PImage bear;
float counter;

void setup(){
  size(400, 400);
  bear = loadImage("nicotine_patch_bear.png");
  imageMode(CENTER);
  counter = 0.0;
}

void draw(){
  background(211);
  
  translate(200, 200);
  pushMatrix();
  rotate(counter);
  image(bear, 0, 0);
  popMatrix();
  
  counter+=0.03;
}

