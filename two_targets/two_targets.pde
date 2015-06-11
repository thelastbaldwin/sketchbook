import processing.opengl.*;

//graph the area
int W = 600;
int H = 600;
int targetIndex = 0;

PVector target;
PVector home;
PVector pt1;
PVector pt2;
PVector location; //seeks the target

void setup(){
  size(W, H, OPENGL);
  pt1 = new PVector(400, 400);
  pt2 = new PVector(0, 600);
  home = new PVector(0, 0);
  location = home; //start at home
}

void draw(){
  background(211);
  
  noStroke();
  fill(255);
  println("location.x = " + location.x + ", location.y= " + location.y);
  
  if(targetIndex == 0){
    PVector dir = PVector.sub(pt1, location);
    dir.normalize();
    dir.mult(10); //need to make a threshold derived from the speed
    location.add(dir);
    if(int(location.x) == pt1.x && int(location.y) == pt1.y){
      println("here");
      targetIndex++;
    }
  }
  else{
    PVector dir = PVector.sub(pt2, location);
    dir.normalize();
    dir.mult(8);
    location.add(dir);
  } 
  
  ellipse(pt1.x, pt1.y, 10, 10); //first target
  ellipse(pt1.x, pt1.y, 10, 10); //second target
  ellipse(home.x, home.y, 10, 10);
}
