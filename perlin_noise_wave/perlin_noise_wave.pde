//aurora globals
int STARTING_HEIGHT = 300;
int STROKE_WEIGHT = 1;
int AMPLITUDE = 100;
int SPEED = 5; //lower is faster

Aurora A;

color c1, c2, c3, c4, c5;

void setup(){
  size(1600, 800, OPENGL);
  strokeWeight(STROKE_WEIGHT);
  strokeCap(SQUARE); //SQUARE will give sharp edges
  
  A = new Aurora();
}

void draw(){
  fill(0, 15);
  rect(0 - STROKE_WEIGHT, 0 - STROKE_WEIGHT, width + STROKE_WEIGHT * 2, height + STROKE_WEIGHT *2);
  
  A.update();
  A.display();
}

color getRelativeColor(int opacity){
  colorMode(HSB, 100);
  int avgMxMy = ((mouseX + mouseY) / 2); 
  
  if(avgMxMy < 100){
    avgMxMy = 100;
  }
  
  return color(avgMxMy/10, avgMxMy, avgMxMy, opacity);
}

  
class Spot{
  int xPos, yPos, height;
  
  Spot(int _xPos, int _yPos){
    xPos = _xPos;
    yPos = _yPos;
    height = int(random(150, 300));
  }
  
  void display(){
    //should draw a series of lines that fade transparency
    stroke(c5);
    line(xPos, yPos, xPos, yPos- height); 
    stroke(c4);
    line(xPos, yPos, xPos, yPos - height/2);   
    stroke(c3);
    line(xPos, yPos, xPos, yPos - height/3);  
    stroke(c2);
    line(xPos, yPos, xPos, yPos - height/4);
    stroke(c1);
    line(xPos, yPos, xPos, yPos - height/5);
  }
  
  int getY(){
    return yPos;
  }
  
  void setY(int y){
    yPos = y;
  } 
  
  void setY(float y){
    yPos = int(y);
  } 
}



class Aurora{
  
  int segments;
  Spot[] spots;
  float timer, offset;
  
  Aurora(){
    segments = calculateSegments(STROKE_WEIGHT, width);
    spots = new Spot[segments];
    timer = 0;
    offset = 0.15;
    
    for(int i = 0; i < segments; i++){
      spots[i] = new Spot(width - i * STROKE_WEIGHT, STARTING_HEIGHT);
    }
  }
  
  void display(){
    for(int i = 0; i < segments; i++){
      spots[i].display();
    }
  }
  
  void update(){
    if (frameCount % SPEED == 0){
      timer += offset;
    }
    
    //shift spot positions
    for(int i = 0; i < spots.length; i++){
      spots[i].setY(STARTING_HEIGHT + (AMPLITUDE * noise(timer + i * offset)));
    }
    
    c1 = getRelativeColor(255);
    c2 = getRelativeColor(100);
    c3 = getRelativeColor(50);
    c4 = getRelativeColor(40);
    c5 = getRelativeColor(25);

  }
  
  int calculateSegments(int sWeight, int width){
    return (width + sWeight)/sWeight;
  }
}
