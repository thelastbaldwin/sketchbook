import controlP5.*;
ControlP5 cp5;

//float frequencyMin = 0.0001;
//float frequencyMax = 2.0;
//
//float amplitudeMin = 0.0001;
//float amplitudeMax = 5.0;
//
//ControlP5 frequencyRange;
//ControlP5 amplitudeRange;

float count;
float frequency;
float amplitude;
int STEP_SIZE;
PVector center;

void setup(){
  size(800, 800, OPENGL);
  count = 0.0;
  frequency = 0.1;
  amplitude = 0.25;
  STEP_SIZE = 8;
  noStroke();
  
  center = new PVector(width/2, height/2);
  
  cp5 = new ControlP5(this);
  Group controls = cp5.addGroup("controls").setPosition(10, 10).setWidth(260).setBackgroundColor(color(0, 200)).setBackgroundHeight(80).activateEvent(true).setLabel("controls");
  cp5.addSlider("frequency").setMin(0.0001).setMax(2.0).setValue(frequency).setPosition(10, 20).setSize(180, 9).setGroup(controls);
  cp5.addSlider("amplitude").setMin(0.0001).setMax(20.0).setValue(amplitude).setPosition(10, 40).setSize(180, 9).setGroup(controls);
}

void draw(){
  background(0);
  for(int i = 0; i < (height * width)/STEP_SIZE; i++){
      PVector position = new PVector(i % width * STEP_SIZE, i / width * STEP_SIZE);
      
      fill(map(cos(PVector.dist(position, center) * amplitude + count), -1, 1, 0, 255));
      rect(i % width * STEP_SIZE, i / width * STEP_SIZE, STEP_SIZE, STEP_SIZE);
  }
  count += frequency;
}

void controlEvent(ControlEvent event){
  String controllerName = event.getController().getName();
  
  if(controllerName == "amplitude"){
      amplitude = event.getController().getValue();
  }
  else if(controllerName == "frequency"){
      frequency = event.getController().getValue();
  }
  println(controllerName + ':' + event.getController().getValue());
}
