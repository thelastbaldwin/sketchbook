class Sand{

    float rot, decay;
    color fil; 
    float x, y;
    int tX, tY;
    
    Sand(float _rot){
      rot = _rot;
      decay = random(0.1, 0.7);
      fil = getRandomColor();
      tX = 0; //default target 0, 0
      tY = 0;
    }
    
    Sand(float _rot, int _tX, int _tY){
      this(_rot); //attempt to call default constructor
      tX = _tX;
      tY = _tY;
    }

    void update(){
      x = width/(time * decay) * cos(time);
      y = height/(time * decay) * sin(time);
    }
    
    void display(){
      pushMatrix();
      translate(width/2 + tX, height/2 + tY);
      rotate(rot);
      fill(fil);
      ellipse(x, y, 3, 3);
      popMatrix();
    }
}
