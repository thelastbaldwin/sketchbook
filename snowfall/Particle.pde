class Particle{
  PVector location,
          velocity,
          acceleration,
          oLocation;
  float   mass,
          size;
  Timer   t;
          
  Particle(int x, int y, float _mass, float _size){
      location = new PVector(x, y);
      oLocation =  new PVector(x,y); //original location
      velocity = new PVector(0, 0);
      acceleration = new PVector(0, 0);
      mass = _mass;
      size = _size;
      t = new Timer(int(random(10, 100))); 
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  boolean atBottom(){
    //stop the particles at the bottom of the screen
    if(location.y > H){
      location.y = H;
      t.start();
      return true;
    }
    
    return false;
  }
  
  PVector calculateFriction(){
    PVector friction = velocity.get();
    friction.normalize();
    friction.mult(-1);
    float c = .04; //coefficient of friction;
    float normal = 1; //simplified normal force value
    float frictionMag = c * normal;
    friction.mult(frictionMag);

    return friction;
  }
  
  PVector calculateWind(){
    //start by applying a constant side wind
    PVector wind = new PVector(int(random(-3,3)), 0);
    wind.normalize();
    return wind;
  }
  
  PVector calculateGravity(){
    PVector gravity = PVector.sub(new PVector(location.x, H), location); //make vector pointing towards mouse
    float distance = gravity.mag(); //distance between particle and mouse
    gravity.normalize();
    return gravity;
  }

  
  void display(){
    ellipse(location.x, location.y, size*2, size*2);
  }
  
  void update(){
    if(t.isFinished()){
      location = new PVector(oLocation.x, 0);
      t.reset();
    }
    
    PVector gravity = calculateGravity();
    PVector friction = calculateFriction();
    
    applyForce(gravity);
    //if the distance between the particle and mouse is less than some threshold 
    //apply the windforce
    if(abs(uWind.x) > 0 && PVector.dist(cPosition, location) < 100){
      applyForce(PVector.mult(uWind, 0.5));
    }
    applyForce(friction);
    
    if(!atBottom()){
      applyForce(calculateWind());
    }
   
    velocity.add(acceleration);
    velocity.limit(TOPSPEED);
    location.add(velocity);
    acceleration.mult(0); //clear acceleration each frame 
  }
}
