int POINT_COUNT = 200;
float[][] points = new float[POINT_COUNT][3];
float offset = 30.0;
float threshold = 1200.0;
float depth = 1200.0;
boolean capture = true;



void setup(){
  size(3240, 1080, OPENGL);
  
  points = generateRandomPoints();
  strokeWeight(2);
  frameRate(30);
}

void draw(){
  background(0); 
  
  float t = millis() * .00005;
  threshold = 400 +  200 * noise(t * 10);
  camera(sin(t) * width/2.0, sin(t) * height/2,cos(t) * depth/2.0, // eyeX, eyeY, eyeZ
        0, 0, 0, // centerX, centerY, centerZ
        0, 1, 0); // upX, upY, upZ

   for(int i = 0; i < points.length; i++){
     for(int j = 0; j < i; j++){
       float distance = dist(points[i][0], points[i][1], points[i][2], points[j][0], points[j][1], points[j][2]);
       if(distance < threshold){
         //closer is exponentially brighter
         float a  = pow(1/(distance/threshold + 1), 3) * 255;
         stroke(255, a);
         line(points[i][0], points[i][1], points[i][2], points[j][0], points[j][1], points[j][2]);
       }
     }
   }
   
   if(capture){
      saveFrame("/Volumes/HD_2/Designer_Preview/4320x1080/3d_lissajous/####.tif");
     if(frameCount >= 30 * 60 * 5){
       exit();
     }
   }
  
}


float[][] generateRandomPoints(){
  float[][] points = new float[POINT_COUNT][3];
  for(int i = 0; i < POINT_COUNT; i++){
    points[i][0] = random(-width/2, width/2);
    points[i][1] = random(-height/2, height/2);
    points[i][2] = random(-depth/2, depth/2);
  }
  return points;
}



