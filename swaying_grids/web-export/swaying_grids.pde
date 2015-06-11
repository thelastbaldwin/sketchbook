PVector origin;
int GRID_COUNT = 8;
Grid[] grids = new Grid[GRID_COUNT];

float counter;
int width = 960;
int height = 800;

void setup(){
  size(960, 800);
  noStroke();
  origin = new PVector(width/2, height * 0.25);
  
  for(int i= 0; i < grids.length; i++){
    grids[i] = new Grid(origin, int(random(15, 20)), int(random(30, 100)), int(random(5, 20)), int(random(10, 100)));
  }
}

void draw(){
  //try to save this whole thing has an animated gif?
  background(255);

  for(int i= 0; i < grids.length; i++){
      grids[i].draw();
    }
  counter = float(millis())/1000;  
}



class Grid{
  PVector origin;
  int count, size, margin, amplitude;
  float offset;
  color fil;

  Grid(PVector _origin, int _count, int _size, int _margin, int _amplitude){
    origin = _origin;
    count = _count;
    size = _size;
    margin = _margin;
    amplitude = _amplitude;
    fil = getRandomColor();
    offset = random(-1, 1);
  }
  
  void draw(){
    fill(fil);
    pushMatrix();
    translate(amplitude * sin(counter + offset) + origin.x, origin.y);
        rotate(PI/4);
    for(int i = 0; i < count; i++){
      for(int j = 0; j < count; j++){
        rect(i * (size + margin),j * (size + margin), size, size);
      }
    }
    popMatrix();
  }
  
  void shiftColor(){
  
  }
}

color getRandomColor(){
  int OPACITY = 50;
  int MAXCOLORS = 3;
  color[] colorList = new color[MAXCOLORS];
  //red
  colorList[0] = color(255, 0, 0, OPACITY);
  //green
  //colorList[1] = color(0, 255, 0, OPACITY);
  //blue
  colorList[1] = color(0, 0, 255, OPACITY);
  //yellow
  colorList[2] = color(255, 255, 0, OPACITY);
  
  return colorList[int(random(colorList.length))];
}

