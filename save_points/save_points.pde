//graph the area
int W = 600;
int H = 600;

PFont font;


void setup(){
  size(W, H);
  font = loadFont("CenturyGothic-10.vlw");
  textFont(font, 10);
  background(75);
}

void draw(){
  
  
  //horizontal lines
  strokeWeight(1);
  stroke(211);
  for(int i = 0; i < H; i += 10){
    line(0, i, W , i);
  }
  //vertical lines
  for(int j=0; j < W; j+=10)
  {
    line(j, 0,j, H);
  }
  
 stroke(0);
  fill(0);
  strokeWeight(2);
  line(250, 300, 350, 300);
  line(300, 250, 300, 350); 
  
}

void mouseDragged(){
  placePoint(mouseX,mouseY);
}

void placePoint(int x, int y){
  noStroke();
  fill(255);
  ellipse(x, y, 5, 5);
  String pointString = "  (" + x + "," + y + ")";
  text(pointString, x, y);  
}
