
ArrayList rings;

int counter = 0;

interface JavaScript {
   void cloneCanvas();
}

void bindJavascript(JavaScript js) {
    javascript = js;
}

Javascript javascript;

void setup() {
  size(640, 640); 

  rings = new ArrayList();
  ringInit("http://www.irocknroll.com/images/Hall_and_Oates.jpg");
  imageMode(CENTER);
 
}

void ringInit(String location){
  rings.add(new Ring(location, 50, 8, -1));
}


void draw() {
  background(201);
   translate(width/2, height/2);
    
   for(int i= 0; i < rings.size(); i++){
     Ring ring = (Ring) rings.get(i);
     ring.update();
     ring.display();
   }   
   
   counter++;
   if(javascript){
     javascript.cloneCanvas();
   }
}

class Ring{
  int count; 
  PImage r_image;
  int radius;
  int rotationDir;
  float speed;
  
  Ring(String r_image_temp, int radius_temp, int count_temp, int rotationDir_temp){
    r_image = loadImage(r_image_temp);
    radius = radius_temp;
    count = count_temp;
    rotationDir = rotationDir_temp;
    speed = this.getRandomSpeed();
  }
  
  void update(){
    rotate(rotationDir * (speed * counter)); 
    radius = mouseX/10 * 5;
  }
  
  void display(){
    for(int i = 0; i < count; i++){ 
      pushMatrix();
      translate(radius * sin((i * TWO_PI)/count), -(radius * cos((i * TWO_PI)/count))); 
      rotate(i * TWO_PI/count);
      image(r_image, 0 , 0);  
      popMatrix();
    }
  }
  
  float getRandomSpeed(){
      float[] speeds = {TWO_PI/64, TWO_PI/128, TWO_PI/256, TWO_PI/512, TWO_PI/1024};
      return speeds[int(random(0, speeds.length))];
  }
}

void clearArrayList(ArrayList al){
  for(int i = 0; i < al.size(); i++){
    al.remove(i);
  }
}

void mousePressed(){
  clearArrayList(rings);
}

