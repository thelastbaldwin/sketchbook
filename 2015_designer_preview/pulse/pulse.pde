import penner.easing.*;

int time= 0;
float beginning= 0;
float change;
float duration = 200;
color f;

void setup(){
  size(800, 800, OPENGL);
  change = width * 1.5;
  f = getRandomColor();
  background(0);
}

void draw(){
  noStroke();
  fill(0, 20);
  rect(0, 0, width, height);
  
  stroke(f);
  strokeWeight(4);
  noFill();
  
  translate(width/2, height/2);
  
  int NUM_CIRCLES = 8;
  float[] sizes = new float[NUM_CIRCLES];
  for(int i = 0; i < NUM_CIRCLES; i++){
    sizes[i] = Quint.easeInOut(time, beginning, change, duration + 0.1 * duration * i);
    ellipse(0, 0, sizes[i], sizes[i]);
  }
//  float size = Quint.easeInOut(time, beginning, change, duration);
//  ellipse(0, 0, size, size);
//  float size2 = Quint.easeInOut(time, beginning, change, duration * 1.2);
//  ellipse(0, 0, size2, size2);
  
  if (time < duration * NUM_CIRCLES * 0.15){
    time++;
  } else {
    f = getRandomColor();
    time = 0;
  }
}

color getRandomColor(){
  return color(int(random(255)), int(random(255)), int(random(255)));
}
