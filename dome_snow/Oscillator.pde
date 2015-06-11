float AVELOCITY = 0.0045; //this will be shared amongst instances
float AMPLITUDE = 100; //half of width or height
float DIST_THRESHOLD = 5.0;

class Oscillator{
  int size, svgIndex;
  float angle, x, y, fallspeed, rotation;
  
  Oscillator(float _angle, int _y, int _size, float _fallspeed, float _rotation){
    x = 0;  
    angle = _angle;
    y = _y;
    size = _size;
    angle = 0.0;
    svgIndex = int(random(0, SVG_COUNT));
    fallspeed = _fallspeed;
    rotation = _rotation;
  }
  
  void update(){  
    angle += AVELOCITY;
    float distFromCenter = PVector.dist(new PVector(x, y), new PVector(0, 0));
    float amplitude = distFromCenter/2;

    x = amplitude * sin(angle);
      
    if (fallspeed > 0){
      y += fallspeed;
    } 
    
    if(distFromCenter < DIST_THRESHOLD){
      y = -H/2 - size * 3;
    }
  }
  
  void display(){
    pushMatrix();
    rotate(rotation);
    shape(snowflakeSVGS[svgIndex], x, y, size, size);
    popMatrix();
  }
  
  void setAngle(float a){
    angle = a;
  }
  
  float getAngle(){
    return angle;
  }
}
