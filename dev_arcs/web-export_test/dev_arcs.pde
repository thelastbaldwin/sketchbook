import processing.opengl.*;

//width and height constants
int W = 800;
int H = 600;
int DEV_COUNT;
String mode = "JAVASCRIPT";

int counter;

color BACKGROUND_COLOR = color(0, 0, 0);

//DevArc[] devArcs = new DevArc[DEV_COUNT];
DevArc[] devArcs;

/**
 *    Define an interface that will act as glue between this sketch
 *    and "real" JavaScript running in the HTML page.
 *
 *    The interface must define all functions that you intend to call
 *    from inside the sketch.
 */
interface Javascript{
    //methods called from Processing go here
}

/* A variable to hold whatever implements the interface. */
JavaScript javascript;

void bindJavascript(JavaScript js) {
  javascript = js;
}

XML xml;
XML[] devs;


void setup(){  
  xml = loadXML("devs.xml");
  devs = xml.getChildren("dev");
  
  size(800, 600, OPENGL);  
  smooth();
  frameRate(60);
  noStroke();
  counter = 0; //could be neatly contained in DevArcs class
  DEV_COUNT = devs.length;

  devArcs = new DevArc[DEV_COUNT]; 
   
  
  //initialize arcs
  for(int i = 0; i < devs.length; i++){
    String name = devs[i].getContent();
    String id = devs[i].getString("id");
    int hexColor = unhex(devs[i].getString("color"));
    
    if(i == 0){
      devArcs[0] = new DevArc(50, 20, -1, hexColor, name);
    }else{
      int t = devArcs[i-1].getRandomThickness();
      devArcs[i] = new DevArc(devArcs[i-1].getRadius()+t, t, -(devArcs[i-1].getDir()), hexColor, name);
    }
  }
 
}

void draw(){  
  //prevent strange fading effect
  //if(counter == 0.0){
    background(BACKGROUND_COLOR);
  //}
  
  //semi-transparent background for hazy effects
  //fill(0, 0, 0, 50); 
  //rect(0, 0, W, H);
  
  noStroke();
  translate(W/2, H/2);
    
  //outer rings must be displayed first in Java mode
  if(mode == "JAVA"){
    for(int j = DEV_COUNT-1; j >= 0; j--){
      devArcs[j].display();
    }
  }
  
  //test for processing.js
  if(mode == "JAVASCRIPT"){
    for(int j = 0; j < DEV_COUNT; j++){
      devArcs[j].display();
    }
  }  
  counter ++;
}


color getRandomColor(){
  return color(int(random(255)), int(random(255)), int(random(255)));
}

int getDevByName(String name){
  for(int i = 0; i < DEV_COUNT; i++){
    if(devArcs[i].name == name){
      return i;
    }
  }
   return -1;
}

DevArc getDev(int index){
  return devArcs[index];
}

class DevArc{
  int arcColor; 
  int totalItems;
  int completedItems;
  int radius;
  float completePercent;
  float speed;
  int thickness;
  int dir; //positive for clockwise, -1 for counter
  String name;
  
  DevArc(int _radius, int _thickness, int _dir){
    arcColor = getRandomColor();
    radius = _radius;
    thickness = _thickness;
    dir = _dir;
    totalItems = 0;
    completedItems = 0;
    speed = getRandomSpeed(); //not really random
  }
  
  DevArc(int _radius, int _thickness, int _dir, int _arcColor, String _name){
    name = _name;
    arcColor = _arcColor;
    radius = _radius;
    thickness = _thickness;
    dir = _dir;
    totalItems = 1;
    completedItems = 0;
    speed = getRandomSpeed(); //not really random
    completePercent = 0;
  }
    
  void display(){
      pushMatrix();
      rotate(speed*counter * dir);
      
      //circle overlay
      fill(BACKGROUND_COLOR);
      ellipse(0, 0, radius-thickness, radius-thickness); 
                 
      //total arc
      fill(arcColor);
      arc(0, 0, radius, radius, 0, (2*PI)*completePercent);         
      
      arc(0, 0, radius-thickness, radius-thickness, 0, (2*PI)*completePercent);
      popMatrix();
  }
  
  void setCompletedItems(int items){
    //completed in test
    completedItems = items;
    completePercent = float(completedItems)/float(totalItems);
  }
  
  void setTotalItems(int items){
    totalItems = items;
    completePercent = float(completedItems)/float(totalItems);
  }
  
  
  int getRadius(){
    return radius;
  }
  
  int getThickness(){
    return thickness;
  }
  
  
  int getDir(){
    return dir;
  }
  
  int getRandomThickness(){
    int[] thicknesses = {20, 60, 30, 40};
    return thicknesses[int(random(0,4))];
  }
  
  float getRandomSpeed(){
    float[] speeds = {PI/200, PI/150, PI/250, PI/180};
    return speeds[int(random(0, 4))];
  }
}
class devArcs{
     devArcs(){
     
     }
     
     void setDevItemCount(String name, int count){
     
     }
     
     void setDevItemComplete(String name, int count){
     
     } 
}

