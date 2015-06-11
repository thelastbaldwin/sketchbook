float increment = 0;

void setup(){
 size( 800, 800, OPENGL);
 strokeWeight(16);
 strokeCap(SQUARE);
 noFill();
}

void draw(){
  fill(255, 50);
  noStroke();
  rect(0, 0, width, height);
  noFill();
  strokeWeight(48);
  stroke(200);
  
  for(int i = 1; i < 25; i++){
    drawArcCircle(width/2, height/2, i * 64, i * 8, (100 * i) - (i + increment));
  }
//  arc(width/2, height/2, 50, 50, 0, PI/2);
//  arc(width/2, height/2, 50, 50, PI, 3 * PI/2);

  increment += 0.005;
}

void drawArcCircle(float x, float y, float radius, float divisions, float offset){
  //we want space in between the segments
  float increment = TWO_PI/(2 * divisions);
  for(float i = 0; i < divisions * 2; i++){
    if(i % 2 == 0){
      arc(x, y, radius, radius, i * increment + offset, i * increment + increment + offset);
    }
  }
}

class ArcCircle{
  PVector location;
  float radius;
  int divisions;
  
  ArcCircle(float _x, float _y, float _radius, int _divisions){
    location = new PVector(_x, _y);
    radius = _radius;
    divisions = _divisions;
  }
}
