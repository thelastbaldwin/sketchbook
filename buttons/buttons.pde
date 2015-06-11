import processing.serial.*;

Serial myPort;
int a = 200;

void setup(){
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.buffer(1);
  size(400, 400);
  background(51);
  noLoop(); //makes draw run only once
}

void draw(){
  fill(a, 0, 0);
  rect(100, 100, width/4, height/4);
  fill(100, 200, 0);
  rect(200, 100, width/4, height/4);
}

void mousePressed(){
  println("Coordinates: " + mouseX + "," + mouseY);
  mouseAction();
}

void mouseAction(){
 if(mouseX > 100 && mouseX < 200){
   if(mouseY > 100 && mouseY < 200){
     println("button off");
     myPort.write(2);
   }
 } 
 if(mouseX > 200 && mouseX < 300){
   if(mouseY > 100 && mouseY < 200){
     println("button on");
     myPort.write(1);
   }
 }
}

