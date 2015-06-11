import java.awt.event.*; 

float counter;
Ring layer1;
Ring layer2;
Ring layer3;

Ring[] layers = new Ring[5];
int zTrans;

void setup(){
  size(800, 800, OPENGL);
  counter = 0.0;
  zTrans = 200;
  noStroke();
  
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
  }});
  
 
  
  layers[0] = new Ring(6, 15, 3, 2, 0, 0, 1); //int _count, int _radius, int _speed, int _size, int xRot, int yRot, int zRot
  layers[1] = new Ring(30, 50, 1, 5, 0, 1, 0);
  layers[2] = new Ring(8, 58, 2, 3, 1, 0, 1); 
  layers[3] = new Ring(12, 70, -1, 4, 1, 1, 0);
  layers[4] = new Ring(15, 80, -2, 5, 1,1 , 1);
}

void draw(){
  fill(0, 0, 0, 50);
  rect(0, 0, width, height);
  //lights();
  directionalLight(50, 0, 0, 1, 0, 0);//directionalLight(v1, v2, v3, nx, ny, nz)
  lightSpecular(255, 255, 255);
  directionalLight(102, 0, 200, 1, 0, -1);//directionalLight(v1, v2, v3, nx, ny, nz)
  specular(183, 224, 255);
  shininess(100.0);
  
  pushMatrix();
  translate(width/2, height/2, height/2); //x, y, z
  
  //replace this with camera code
  camera((mouseX - 400)*0.3, (mouseY - 400) *0.3, zTrans,0, 0, 0, 0.0, 1.0, 0.0);
   
  //Axes();
  fill(175);
  
  
  for(int i = 0; i < layers.length; i++){
    layers[i].display();
  }

  counter += 0.01;
  popMatrix();
}

class Ring{
  int count;
  int radius;
  int size;
  float speed;
  int originX;
  int originY;
  int originZ;
  int rotation[] = new int[3]; //x, y, and z rotations
  
  Ring(int _count, int _radius, int _speed, int _size, int xRot, int yRot, int zRot){
    count = _count;
    radius = _radius;
    speed = _speed;
    size = _size;
    setRotation(xRot, yRot, zRot);
  }
  
  void setRotation(int x, int y, int z){
    rotation[0] = x;
    rotation[1] = y;
    rotation[2] = z;
  }
  
  void update(){
    rotate(counter * speed,rotation[0],rotation[1],rotation[2]);
  }
  
  void display(){
    pushMatrix();
    update();
    for(int i = 0; i < count; i ++){ 
       pushMatrix();     
       translate(radius * sin((i* TWO_PI)/count),radius * cos((i* TWO_PI)/count),0);
       sphere(size);
       popMatrix();
    }   
    popMatrix();
  }
  
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
    }
    if(keyCode == DOWN){
    }
    if(keyCode == LEFT){  
    }
    if(keyCode == RIGHT){
    }    
  }
}

void Axes(){
  //y
  fill(255,0,0);
  box(1, 50, 1);
  //x
  fill(0,0,255);
  box(50, 1, 1);
  //z 
  fill(0);
  box(1, 1, 50);
  fill(255);
}

void mouseWheel(int delta) {
  println("mouse has moved by " + delta + " units."); 
  zTrans+=delta * 5;
}
