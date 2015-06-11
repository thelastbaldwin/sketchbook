//graph the area
int W = 600;
int H = 600;
int pointCount = 0; //shitty counter for points
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
  
  //sample bezier
  noFill();
  stroke(255, 102, 0);
  line(85, 20, 10, 10);
  line(90, 90, 15, 80);
  stroke(0, 0, 0);
  bezier(85, 20, 10, 10, 90, 90, 15, 80); //think of it like two lines
  testBez(431, 388,441, 206, 200, 396, 198, 218);
}

void mouseClicked(){
  placePoint(mouseX,mouseY);
}

void testBez(int x1,int y1,int x2,int y2,int x3,int y3,int x4,int y4){
  stroke(color(#615FFF));
  line(x1, y1, x2, y2);
  line(x3, y3, x4, y4);
  stroke(0);
  bezier(x1, y1, x2, y2, x3, y3, x4, y4);
}

void placePoint(int x, int y){
  int points = 0;
  noStroke();
  ellipse(x, y, 5, 5);
  String pointString = "  (" + x + "," + y + ")";
  text(pointString, x, y);  
  println("Point " + pointCount + " : (" + x + ", " + y + ")");
}
