int TOPSPEED = 5;
int MAX_PARTICLES = 1000;
Particle[] particles = new Particle[MAX_PARTICLES];
PVector mouse;
PVector target;
int timer;
boolean bTarget;

void setup(){
  timer = 0;
  bTarget = false;
  target = new PVector();
  mouse = new PVector(mouseX, mouseY);
  size(640, 480, OPENGL);
  noStroke();


  //initialize paticles
  for(int i = 0; i < particles.length; i++){
    particles[i] = new Particle(int(random(0, width)), //x
    int(random(0, height)), //y
    int(random(2, 50)),	//mass
    int(random(2, 6))); //size
  }
}

void draw(){
  fill(0, 10);
  rect(0, 0, width, height);
  updateTarget(50);
  fill(255);
  for(int i = 0; i < particles.length; i++){
    particles[i].update();
    particles[i].display();    
  }
  timer++;
}

void updateTarget(int duration){
  if(timer % duration == 0){
    bTarget = !bTarget;
    target = new PVector(random(width), random(height));
  }
//  target = (bTarget)? new PVector(width/4, height/2) : new PVector(3 * width/4, height/2);
}

void updateMouseVector(){
	// to prevent the mouse from updating too often
	mouse.x = mouseX;
	mouse.y = mouseY;
}

class Particle{
	PVector location, 
			velocity,
			acceleration;
	float 	mass,
			size;

	Particle(int x, int y, float _mass, float _size){
		// particle class should have location, velocity, acceleration, friction, and gravity
		// particles should be attracted to mouse
		location = new PVector(x, y);
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		mass = _mass;
		size = _size;
	}

	void display(){
		ellipse(location.x, location.y, size*2, size*2);
	}

	PVector calculateFriction(){
		PVector friction = velocity.get();
		friction.normalize();
		friction.mult(-1);
		float c = 0.4; //coefficient of friction;
		float normal = 1; //simplified normal force value
		float frictionMag = c * normal;
		friction.mult(frictionMag);

		return friction;
	}

	PVector calculateGravity(){
		PVector gravity = PVector.sub(target, location); //make vector pointing towards mouse
		float distance = gravity.mag(); //distance between particle and mouse
		float mouseMass = 2000.0; //arbitrary value
		float G = 1.0; //arbitrary gravitational constant
		float m = (G * mouseMass * mass)/(distance * distance); //use formula for gravity to get strength of force
		gravity.normalize();
		gravity.mult(m);
		return gravity;
	}

	void applyForce(PVector force){
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void checkEdges(){
		//ensure that the particles remain on screen
		if(location.x > width || location.x < 0){
			//location.x = width;
			//velocity.mult(-1);
			velocity.x = -velocity.x;
		}
		if(location.y > height || location.y < 0){
			// location.y = height;
			//velocity.mult(-1);
			velocity.y = -velocity.y;
		}
	}

	void update(){	
		PVector gravity = calculateGravity();
		PVector friction = calculateFriction();

		// mouse gravity should reverse on click
		if(mousePressed){
			gravity.mult(-2);
		}	

		applyForce(gravity);
		applyForce(friction);

		velocity.add(acceleration);
		velocity.limit(TOPSPEED);
		location.add(velocity);
		checkEdges();
		acceleration.mult(0); //clear acceleration each frame
  	}
};
