String url = "PembrokeLucy2.jpg";
PImage myImage;

void setup(){
  size(640, 640);
}

int radius = 150;
int count = 8;

void draw(){
  translate(width/2, height/2);
  for(int i = 0; i < count; i++){
    rect(radius * sin((i * TWO_PI)/count), radius * cos((i * TWO_PI)/count), 50, 50);
  }
}
