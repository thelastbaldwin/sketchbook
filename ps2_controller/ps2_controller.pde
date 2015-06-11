import procontroll.*;
import net.java.games.input.*;

ControllIO controll;
ControllDevice ps2;

void setup(){
  size(200, 200);
 
 controll = ControllIO.getInstance(this);
 
 ps2 = controll.getDevice("Twin USB Joystick");
 println("ps2 buttons");
 ps2.printButtons();
 ps2.plug(this, "TriPress", controll.ON_PRESS, 0);
 ps2.plug(this, "OPress", controll.ON_PRESS, 1);
 ps2.plug(this, "XPress", controll.ON_PRESS, 2);
 ps2.plug(this, "SqPress", controll.ON_PRESS, 3);
 //controll.printDevices();
}

void draw(){
  rect(width/2-50, height/2-50, 100, 100);
}

void OPress(){
  println("OPress");  
  fill(255, 0, 0);
}

void TriPress(){
  println("TriPress");
  fill(255, 255, 0);
}

void XPress(){
  println("XPress");
  fill(0, 255, 255);
}

void SqPress(){
  println("SqPress");
  fill(0, 0, 255);
}

