
Ring myRing;

int counter = 0;

void setup() {
  size(640, 640); 
  //myRing = new Ring("http://i399.photobucket.com/albums/pp71/crawfordcpa/PembrokeLucy2.jpg", 200, 8);
  myRing = new Ring("PembrokeLucy2.jpg", 200, 8, 1); //must be initialized here
  imageMode(CENTER);
 
}


void draw() {
   background(201);
   translate(width/2, height/2);
   
   
   myRing.update();
   myRing.display();
   counter++;
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
      image(r_image, 0 , 0 , 50, 50);  
      popMatrix();
    }
  }
  
  float getRandomSpeed(){
      float[] speeds = {TWO_PI/32, TWO_PI/64, TWO_PI/128, TWO_PI/256, TWO_PI/512};
      return speeds[int(random(0, speeds.length))];
  }
}
