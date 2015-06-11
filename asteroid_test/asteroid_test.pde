int MAX_ASTEROID_COUNT = 10;
int WINDOW_HEIGHT = 600;
int WINDOW_WIDTH = 800;

Asteroid[] asteroids = new Asteroid[MAX_ASTEROID_COUNT];

Asteroid asteroid1;

void setup(){
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
  for(int i = 0; i < MAX_ASTEROID_COUNT; i++)
  {
    asteroids[i] = new Asteroid(int(random(50, 750)), 600, 50);
  }
}

void draw(){
  background(0);
  //player placeholder
  fill(0, 0, 255);
  rect(400-25, 300-25, 50, 50);
  for(int i = 0; i < MAX_ASTEROID_COUNT; i++)
  {
   asteroids[i].updatePosition();
    asteroids[i].displayAsteroid();
  }
}

class Asteroid{
  PVector position;
  PVector speed;
  int aSize;
  
  Asteroid(int _xPos, int _yPos, int _aSize){
    position = new PVector(_xPos, _yPos);
    speed = new PVector(int(random(-5,5)), -int(random(1, 5)));
    aSize = _aSize;
  }
  
  boolean outOfBounds(){
    if(position.x < 0-aSize || position.x > WINDOW_WIDTH+aSize || position.y < 0-aSize)
    {
      return true;
    }
    return false;
  }
  
  void updatePosition(){
    if(outOfBounds()){
      position.x = int(random(50, 750)); //x range +/- 50
      position.y = 600; //y always at bottom
      speed = new PVector(int(random(-3,3)), -int(random(3, 5)));
    }
    
    position.x = position.x + speed.x;
    position.y = position.y + speed.y;
  }
  
  void displayAsteroid()
  {
    fill(255, 255, 255);
    rect(position.x, position.y, aSize, aSize);
  }
}
