class Ring{
  float opacity, size, speed;
  PVector location;
  
  //top, left, bottom, right
  boolean[] edges;
  
  Ring(){
    location = new PVector(int(random(width)), int(random(height)));
    opacity = random(100.0, 255.0);
    size = random(100.0);
    speed = 1.0;
    edges = checkBounds();
  }
  
  Ring(int _x, int _y, float _opacity, float _size, float _speed){
    location = new PVector(_x, _y);
    opacity = _opacity;
    size = _size;
    speed = _speed;
    edges = checkBounds();
  }
  
  Ring(float _x, float _y, float _opacity, float _size, float _speed){
    location = new PVector(_x, _y);
    opacity = _opacity;
    size = _size;
    speed = _speed;
    edges = checkBounds();
  }
  
  boolean[] checkBounds(){
    boolean[] edges = {false, false, false, false};
    
    //top    
    if(this.location.y - this.size/2.0 <= 0){
      edges[0] = true;
    }
    //left
    if(this.location.x - this.size/2.0 <=0){
      edges[1] = true;
    }
    //bottom
    if(this.location.y + this.size/2.0 >= height){
      edges[2] = true;
    }
    //right
    if(this.location.x + this.size/2.0 >= width){
      edges[3] = true;
    }
    
    return edges;
  }
  
  boolean isFinished(){
    if(opacity * 3 <= 0.0){
      return true;
    }
    return false;
  }
  
  void update(){
    opacity -= speed;
    size += pow(speed, 1.5);
  }
  
  void display(){ 
    strokeWeight(4);
    stroke(255, opacity);
    ellipse(location.x, location.y, size, size);
  } 
}
