float increment;
int STEP_SIZE;

void setup(){
  size(800, 800, OPENGL);
  increment = 0.01;
  STEP_SIZE = 4;
  noStroke();
}

void draw(){
  background(0);
  for(int i = 0; i < (height * width)/STEP_SIZE; i++){
      fill(map(noise(increment + float(i * STEP_SIZE)/10.0), 0, 1, 0, 255));
      rect(i % width * STEP_SIZE, i / width * STEP_SIZE, STEP_SIZE, STEP_SIZE);
  }
  increment += 0.1425;
}
