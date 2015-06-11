import processing.serial.*;
Serial Arduino;

void setup(){
  println(Serial.list());
  size(200, 600);
  Arduino = new Serial(this, Serial.list()[0], 9600);
  //Arduino.buffer(1);
  noStroke();
  noLoop();
}

void draw()
{
  //red button
  fill(255, 0, 0);
  rect(0, 0, 200, 200);
  //yello button
  fill(255, 255, 0);
  rect(0, 200, 200, 200);
  //green button
  fill(0, 255, 0);
  rect(0, 400, 200, 200);
}

void mouseClicked(){
 if(mouseX >= 0 && mouseX <= 200 && mouseY >=0 && mouseY <= 200)
   Arduino.write(7);
 if(mouseX >= 0 && mouseX <= 200 && mouseY >200 && mouseY <= 400)
   Arduino.write(4);
 if(mouseX >= 0 && mouseX <= 200 && mouseY >400 && mouseY <= 600)
   Arduino.write(2);
}

