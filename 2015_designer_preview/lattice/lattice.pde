import controlP5.*;
ControlP5 cp5;

int speed = 1;
float xPos = 0.0;
int spacing = 100;
float angle = 0;
float amount = 0.005;

PShader RGBShift, Polar;

void setup(){
  size(1200, 400, OPENGL);
  background(0);
  
  RGBShift = loadShader("RGBShift.glsl"); 
  textureWrap(REPEAT);
  Polar = loadShader("rect_to_polar.glsl");
  Polar.set("resolution", float(width), float(height));
  
  cp5 = new ControlP5(this);
  Group controls = cp5.addGroup("controls").setPosition(10, 10).setWidth(260).setBackgroundColor(color(0, 200)).setBackgroundHeight(60).activateEvent(true).setLabel("controls");
  cp5.addSlider("angle").setMin(0.0).setMax(TWO_PI).setValue(angle).setPosition(10, 20).setSize(180, 9).setGroup(controls);
  cp5.addSlider("amount").setMin(0.0001).setMax(0.5).setValue(amount).setPosition(10, 40).setSize(180, 9).setGroup(controls);
}

void draw(){
  drawFullScreenRect(50);
  strokeWeight(3);
  noFill();
  
  pushMatrix();
  translate(width/2, height/2);
//  rotate(millis() * .00001);
  
  for(int i = 0; i < 16; i++){
      rotate(i * PI/8);
      
      stroke(190, 190, 200);
      line(xPos - spacing, -height, xPos - spacing, height);
      stroke(200, 200, 210);
      line(xPos - spacing * 2, -height, xPos - spacing * 2, height);
      stroke(210, 210, 220);
      line(xPos - spacing * 3, -height, xPos - spacing * 3, height);
      stroke(220, 220, 230);
      line(xPos, -height, xPos, height);
      stroke(230, 230, 240);
      line(xPos + spacing, -height, xPos + spacing, height);
      stroke(240, 240, 250);
      line(xPos + spacing * 2, -height, xPos + spacing * 2, height);
      stroke(250, 250, 255);
      line(xPos + spacing * 3, -height, xPos + spacing * 3, height);
  }
  popMatrix();
  
  xPos = (sin(millis() * 0.0001) * width/4) + 50;
  
  RGBShift.set("angle", angle);
  RGBShift.set("amount", amount);
  filter(Polar);
  filter(RGBShift);
}

void drawFullScreenRect(int opacity){
  noStroke();
  fill(0, opacity);
  rect(0, 0, width, height);
}

class LineGroup{
  LineGroup(int numLines){
  }
}
