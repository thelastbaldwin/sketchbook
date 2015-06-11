//import android.view.MotionEvent;

float time;
int MAX_SAND = 500;
Sand[] sand = new Sand[MAX_SAND];

void setup(){
  background(255);
  size(600, 600);
  noStroke();
  
  reset(0, 0);
}

void draw(){
  //background(211); //activate boring mode
  time+=0.2;
  
  //goes outward
  //fill(255, 0, 0);
  //ellipse(width/2 + 50 * sin(time) * time/10, height/2 + 50 * cos(time) * time/10, 10, 10);

  //goes inward
 // fill(0, 255, 255);
  
  //ellipse(width/2 + width/2 * cos(time), height/2 + height/2 * sin(time), 10, 10);  
  //translate(width/2, height/2);

  //ellipse(width /(time *0.5) * cos(time), height/(time*0.5) * sin(time), 10, 10); //0, 0
  //ellipse(width/2 + (width /time) * cos(time), height/2 + (height/time) * sin(time), 10, 10); //center, without translate
  //ellipse(width + (width /time) * cos(time),100 + (height/time) * sin(time), 10, 10); //center, without translate
  
  for(int i = 0; i < sand.length; i++){
    sand[i].update();
    sand[i].display();
  }
}

void mouseClicked(){
 reset(mouseX - width/2, mouseY - height/2);
}

void mousePressed(){
  //MotionEvent me = (MotionEvent) mouseEvent.getNative();
  reset(mouseX - width/2, mouseY - height/2);
}

void reset(int x, int y){
  println("x = " + x + ", y = " + y);
  time = 0;
  //fill(255);
  //rect(0, 0, width, height);
  
  for(int i = 0; i < sand.length; i++){
    sand[i] = new Sand(i, x, y);
  }
}

color getRandomColor(){
  return color(int(random(255)), int(random(255)),int(random(255)));
}
