int TOPSPEED = 5;
float CF = 0.5; //coefficient of friction;
int MAX_PARTICLES = 1000;
Particle[] particles = new Particle[MAX_PARTICLES];
PVector mouse;

void setup(){
	mouse = new PVector(mouseX, mouseY);
	size(1200, 800);
	noStroke();

	//initialize paticles
	for(int i = 0; i < particles.length; i++){
    	particles[i] = new Particle(int(random(0, width)), //x
    								int(random(0, height)), //y
    								random(2, 50),	//mass
    								random(1, 4), //size
    								random(100, 250)); //rotation threshold
  	}
}

void draw(){
	fill(0, 10);
	rect(0, 0, width, height);
	updateMouseVector();
	fill(255, 0, 0);
	for(int i = 0; i < particles.length; i++){
		particles[i].update();
		particles[i].display();    
	}
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
			size,
			threshold;
	int dir;

	Particle(int x, int y, float _mass, float _size, float _threshold){
		// particle class should have location, velocity, acceleration, friction, and gravity
		// particles should be attracted to mouse
		location = new PVector(x, y);
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		mass = _mass;
		size = _size;
		threshold = _threshold;

		//set rotation direction
		dir = (int(random(0, 2)) < 1) ? 1: -1;
	}

	void display(){
		ellipse(location.x, location.y, size*2, size*2);
	}

	PVector calculateFriction(){
		PVector friction = velocity.get();
		friction.normalize();
		friction.mult(-1);
		float normal = 1; //simplified normal force value
		float frictionMag = CF * normal;
		friction.mult(frictionMag);

		return friction;
	}

	PVector calculateGravity(){
		PVector gravity = PVector.sub(mouse, location); //make vector pointing towards mouse
		float distance = gravity.mag(); //distance between particle and mouse
		float mouseMass = 500.0; //arbitrary value
		float G = 10.0; //arbitrary gravitational constant
		float m = (G * mouseMass * mass)/(distance * distance); //use formula for gravity to get strength of force
		gravity.normalize();
		gravity.mult(m);
		return gravity;
	}

	PVector calculateTangent(PVector gravity){
		PVector tangent;
		
		if(dir == 1){
			tangent =  new PVector(-gravity.y, gravity.x);
		}
		else{
			tangent =  new PVector(gravity.y, -gravity.x);
		}
		tangent.mult(gravity.mag());
		return tangent;
	}

	void applyForce(PVector force){
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void checkEdges(){
		//ensure that the particles remain on screen
		if(location.x > width || location.x < 0){
			velocity.x = -velocity.x;
		}
		if(location.y > height || location.y < 0){
			velocity.y = -velocity.y;
		}
	}

	void update(){	
		PVector gravity = calculateGravity();
		PVector friction = calculateFriction();
		float distance = PVector.dist(location, mouse);

		//particles should be repelled on click
		if(mousePressed){
			PVector rgrav = calculateGravity();
			rgrav.mult(-1.1);
			applyForce(rgrav);
		}

		applyForce(gravity);
		applyForce(friction);

		if(PVector.dist(location, mouse) <= threshold){
			PVector tangent = calculateTangent(gravity);
			applyForce(tangent);
		}

		velocity.add(acceleration);

		velocity.limit(TOPSPEED);
		location.add(velocity);
		checkEdges();
		acceleration.mult(0); //clear acceleration each frame
  	}
};
