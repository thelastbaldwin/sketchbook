PVector pMouse;
PVector mouse;
Timer  mouseDiff;

void setup(){
  size(600, 600);
  pMouse = new PVector(mouseX, mouseY);
  mouse = new PVector(mouseX, mouseY);
  mouseDiff = new Timer(50);
  mouseDiff.start();
}

void draw(){
  background(201);
  
  if(mouseDiff.isFinished()){
    shiftPositions();
    mouseDiff.reset();
    mouseDiff.start();
    println("delta x = " + (mouse.x - pMouse.x) + ", delta y = " + (mouse.y - pMouse.y));
  }
   
   line(pMouse.x, pMouse.y, mouse.x, mouse.y);
}

void shiftPositions(){
  pMouse.x = mouse.x;
  pMouse.y = mouse.y;

  mouse.x = mouseX;
  mouse.y = mouseY;
}
