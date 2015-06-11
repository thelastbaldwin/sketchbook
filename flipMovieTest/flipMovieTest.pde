  
import processing.video.*;
Movie myMovie;

void setup() {
  size(800, 600);
  myMovie = new Movie(this, "Arm-Flip-3.mov");
  myMovie.loop();
}

void draw() {
  image(myMovie, 0, 0);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
