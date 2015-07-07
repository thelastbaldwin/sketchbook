import megamu.mesh.*;

int POINT_COUNT = 200;
float[][] points = new float[POINT_COUNT][2];
float[][] originalPoints = new float[POINT_COUNT][2];
float offset = 50.0;

boolean capture = false;

Delaunay myDelaunay;

void setup(){
  size(4320, 1080, OPENGL);
  
  for(int i = 0; i < POINT_COUNT; i++){
//    float x = random(0, width
    points[i][0] = random(-100, width + 100);
    points[i][1] = random(-100, height + 100);
    
    originalPoints[i][0] = points[i][0];
    originalPoints[i][1] = points[i][1];
  }
 
   myDelaunay = new Delaunay(points);
   println(myDelaunay.getEdges().length);
   frameRate(30);
}

void draw(){
  noStroke();
  fill(0, 50);
  rect(0, 0, width, height);

for(int i = 0; i < POINT_COUNT; i++){
    points[i][0] = map(noise(millis() * .0007 + i), 0.0, 1.0, originalPoints[i][0] - offset, originalPoints[i][0] + offset);
    points[i][1] = map(noise(millis() * .0005 + i), 0.0, 1.0, originalPoints[i][1] - offset, originalPoints[i][1] + offset);
  }
 
   myDelaunay = new Delaunay(points);
  
  float[][] myEdges = myDelaunay.getEdges();

  stroke(255);
  strokeWeight(2);
 
 for(int i = 0; i < myEdges.length; i++){  
    float startX = myEdges[i][0];
    float startY = myEdges[i][1];
    float endX = myEdges[i][2];
    float endY = myEdges[i][3];
    line(startX, startY, endX, endY);
   }
   
   if(capture){
      saveFrame("/Volumes/HD_2/Designer_Preview/4320x1080/delaunay/####.tif");
     if(frameCount >= 30 * 60 * 5){
       exit();
     }
   }
 

//  i++;
//  i %= myEdges.length - 200;
}


