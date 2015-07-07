int POINT_COUNT = 200;
float[][] points = new float[POINT_COUNT][2];
float[][] originalPoints = new float[POINT_COUNT][2];
float offset = 10.0;
float threshold = 1200.0;

boolean capture = true;

void setup(){
  size(4320, 1080, OPENGL);
  
  for(int i = 0; i < POINT_COUNT; i++){
    points[i][0] = random(-100, width + 100);
    points[i][1] = random(-100, height + 100);
    
    originalPoints[i][0] = points[i][0];
    originalPoints[i][1] = points[i][1];
  }

   strokeWeight(2);
   frameRate(30);
}

void draw(){
  background(0);

for(int i = 0; i < POINT_COUNT; i++){
    points[i][0] = map(noise(millis() * .0007 + i), 0.0, 1.0, originalPoints[i][0] - offset, originalPoints[i][0] + offset);
    points[i][1] = map(noise(millis() * .0005 + i), 0.0, 1.0, originalPoints[i][1] - offset, originalPoints[i][1] + offset);
  }
 

   for(int i = 0; i < points.length; i++){
     for(int j = 0; j < i; j++){
       float distance = dist(points[i][0], points[i][1], points[j][0], points[j][1]);
       if(distance < threshold){
         //closer is exponentially brighter
         float a  = pow(1/(distance/threshold + 1), 6) * 255;
         stroke(255, a);
         line(points[i][0], points[i][1], points[j][0], points[j][1]);
       }
     }
   }
   
   if(capture){
      saveFrame("/Volumes/HD_2/Designer_Preview/4320x1080/delaunay_lissajous/####.tif");
     if(frameCount >= 30 * 60 * 5){
       exit();
     }
   }
}


