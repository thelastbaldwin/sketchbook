//create a series of snowflakes that "fall" from the outer edge to the center
//flakes should scale up as they approach center
int MAX_PARTICLES = 25;
int W = 1000;
int H = 1000;

int SVG_COUNT = 6;
PShape[] snowflakeSVGS = new PShape[SVG_COUNT];
Oscillator[] particles = new Oscillator[MAX_PARTICLES];

// PImage mask;

void setup(){
  size(W, H, OPENGL);
  smooth();
  noStroke();
  //load graphics assets
  for(int i = 0; i < SVG_COUNT; i++){
    snowflakeSVGS[i] = loadShape("img/snowflake0" + (i+1) + ".svg");
  }
  
  //initialize particles
  for(int i = 0; i < particles.length; i++){
    particles[i] = new Oscillator(
        random(0, 500),  //starting angle
        -int(random(H/10, H/2)),  //starting height
        int(random(50, 100)), //size
        1.5 * noise(i),  //fall speed
        i * (PI/8)); //rotation
        
        println(1.5 * noise(i));
  }
  
  // mask = loadImage("img/mask.jpg");
}

void draw(){
  fill(0, 50);
  rect(0, 0, W, H);

  translate(width/2, height/2);
  for(int i = 0; i < particles.length; i++){
    particles[i].update();
    particles[i].display(); 
  }  
  
  // blend(mask, 0, 0, width, height, 0, 0, width, height, SCREEN);
}


