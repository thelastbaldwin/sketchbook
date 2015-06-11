int MAX_RINGS = 200;
ArrayList<Ring> rings;

void setup(){
  size(800, 800, P3D);
  noFill();
  
  rings = new ArrayList<Ring>();
//  for(int i = 0; i < MAX_RINGS; ++i){
//    rings.add(new Ring());
//  }
}

void update(){  
  //remove items from array if they're finished
  for(int i= rings.size() - 1; i >= 0; i--){
    Ring ring = rings.get(i);
    ring.update(); 
    boolean[] bounds = ring.checkBounds();
    //add new rings if they're touching the top, left, bottom,
    //or right edges
   
    //top  
    if(ring.edges[0] == false && bounds[0] == true){
      ring.edges[0] = true;
      Ring topMirror = new Ring(ring.location.x, -ring.location.y, ring.opacity, ring.size, ring.speed);
      topMirror.edges[0] = true; //do not "re-reflect" on the top
      rings.add(topMirror);
    }
    //left
    if(ring.edges[1] == false && bounds[1] == true){
      ring.edges[1] = true;
      Ring leftMirror = new Ring(-ring.location.x, ring.location.y, ring.opacity, ring.size, ring.speed);
      leftMirror.edges[1] = true; //do not "re-reflect" on the left
      rings.add(leftMirror);
    }
    //bottom
    if(ring.edges[2] == false && bounds[2] == true){
      ring.edges[2] = true;
      Ring bottomMirror = new Ring(ring.location.x, 2 * height - ring.location.y, ring.opacity, ring.size, ring.speed);
      bottomMirror.edges[2] = true; //do not "re-reflect" on the right
      rings.add(bottomMirror);
    }
    //right
    if(ring.edges[3] == false && bounds[3] == true){
      ring.edges[3] = true;
      Ring rightMirror = new Ring(2 * width - ring.location.x, ring.location.y, ring.opacity, ring.size, ring.speed);
      rightMirror.edges[3] = true; //do not "re-reflect" on the bottom
      rings.add(rightMirror);
    }
    
    if(ring.isFinished()){
      rings.remove(i);
    }
  }
}

void draw(){
  update();
  
  background(49, 229, 207);  
  
//  testRing.update();
//  testRing.display();
//  println(testRing.opacity);

  for(int i= rings.size() - 1; i >= 0; i--){
    Ring ring = rings.get(i);
    ring.display();
  }
}

void mouseMoved(){
  if(rings.size() < MAX_RINGS){
    //Ring(int _x, int _y, float _opacity, float _size, float _speed)
    rings.add(new Ring(mouseX, mouseY, 100.0, 50.0, 5.0));
  }
}
