float t;
float radius;

float[] positions = new float[6];
color c;

PShader metaballs;

void setup(){
  size(1200, 400, OPENGL);
  radius = 50.0;
 
  c = color(255.0);
  
  for(int i = 0; i < 2; i++){
    positions[i] = random(width);
    positions[i + 1] = random(height);
  }
  
  metaballs = loadShader("metaballs.glsl");
  metaballs.set("radius", radius);
//  metaballs.set("color", c);
}

void draw(){
  positions[2][0] = mouseX;
  positions[2][1] = height - mouseY;
  metaballs.set("position", positions, 6);
  
  shader(metaballs);
  
  t = millis() * .01;
//  
//  mb.update();
//  mb.display();
//  
  noStroke();
  rect(0, 0, width, height);
 
}

color getRandomColor(){
  return color(int(random(255)), int(random(255)),int(random(255)));
}

