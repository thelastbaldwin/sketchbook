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
  line(250, 300, 350, 300);
  line(300, 250, 300, 350); 
}

void mouseClicked(){
  placePoint(mouseX,mouseY);
}

void placePoint(int x, int y){
  noStroke();
  ellipse(x, y, 5, 5);
  String pointString = "  (" + x + "," + y + ")";
  text(pointString, x, y);  
}

