int count;
int layer;

void setup(){
 noStroke();
  size(640, 640);
  noLoop();
}

void draw(){
  background(211);
  translate(width/2, height/2);
  layer = 0;
  count = 64;
  
  for(int radius = 200; radius > 0; radius-=10){
    layer++;  
    for(int i = 0; i < count; i++){
      //count /= layer;
      part(radius * sin((i * TWO_PI)/count), radius * cos((i * TWO_PI)/count), 10);
      //ellipse(radius * sin((i * TWO_PI)/(count)), radius * cos((i * TWO_PI)/(count)), 10, 10);
    }
    count *=0.95;
  }
  save("placement.png");
}

void part(float x, float y, float radius){ //placeholder for particle
  fill(255, 255, 255, 75);
  ellipse(x, y, radius, radius);
 fill(255, 255, 255, 150);
  ellipse(x, y, radius/2, radius/2);
 fill(255, 255, 255);
  ellipse(x, y, radius/3, radius/3); 
} 
