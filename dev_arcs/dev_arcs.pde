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
   
  
  //initialize all loops
  for(int i = 0; i < devs.length; i++){
    String name = devs[i].getContent();
    String id = devs[i].getString("id");
    int hexColor = unhex(devs[i].getString("color"));
    println("hexColor: " + hexColor);
    
    if(i == 0){
      //manually set
      devArcs[0] = new DevArc(50, 20, -1, hexColor, name);
    }else{
      int t = devArcs[i-1].getRandomThickness();
      devArcs[i] = new DevArc(devArcs[i-1].getRadius()+t, t, -(devArcs[i-1].getDir()), hexColor, name);
      devArcs[i].setTotalItems(int(random(30, 50)));
      devArcs[i].setCompletedItems(int(random(1, 50)));
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

int getDev(String name){
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



