XML xml;
color[] myColors;
int counter;

void setup() {
  xml = loadXML("devs.xml");
  XML[] devs = xml.getChildren("dev");
  counter = 0;
  
 frameRate(10);
 
 myColors = new color[devs.length]; 
 for (int i = 0; i < devs.length; i++) {
    String id = devs[i].getString("id");
    String name = devs[i].getContent();
    int hexColori = unhex(devs[i].getString("color"));
    myColors[i] = hexColori;
   
    
    //myColor = hexColori;
    println(hexColori);
    //println("id:  " + id + ", name:  " + name);
  }
}

void draw(){
  
  background(myColors[counter%11]);
  counter++;
}
