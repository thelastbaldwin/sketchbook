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
    println(_arcColor);
    name = _name;
    arcColor = _arcColor;
    radius = _radius;
    thickness = _thickness;
    dir = _dir;
    totalItems = 0;
    completedItems = 0;
    speed = getRandomSpeed(); //not really random
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
