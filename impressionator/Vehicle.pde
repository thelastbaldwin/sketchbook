// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// The "Vehicle" class

class Vehicle {
    ArrayList<PVector> history = new ArrayList<PVector>();
  
  PVector prevLocation;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Vehicle(float x, float y) {
    acceleration = new PVector(0,0);
    velocity = new PVector(0,-2);
    location = new PVector(x,y);
    prevLocation = location.get();
    r = random(1, 4);
    maxspeed = 5;
    maxforce = 0.01;
  }

  // Method to update location
  void update() {
    prevLocation = location.get();
    
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);

    checkBounds();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target) {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    
    PVector wind = new PVector(random(-5, 5), random(-5, 5));
    wind.normalize();
    wind.mult(0.25);
    applyForce(wind);
    
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
    
  }
    
  void display() {
//       int pixelIndex = (int)((video.width-1-location.x) + location.y*video.width);
       color c = video.get(width-(int)location.x, (int)location.y);
       float saturation = constrain(saturation(c) * 1.7, 0, 255);
       colorMode(HSB, 255);
       c = color(hue(c), saturation, brightness(c) * 1.2);
       fill(c, 100);
       
       // Draw a triangle rotated in the direction of velocity
      float theta = velocity.heading2D() + PI/2;
      pushMatrix();
      translate(location.x,location.y);
      rotate(theta);
      beginShape();
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      popMatrix();
  }
  
  void checkBounds(){
    if(location.x < 0){
      location.x = width;
    }
    if(location.x > width){
      location.x = 0;
    }
    if(location.y < 0){
      location.y = height;
    }
    if(location.y > height){
      location.y = 0;
    }
  }
}

