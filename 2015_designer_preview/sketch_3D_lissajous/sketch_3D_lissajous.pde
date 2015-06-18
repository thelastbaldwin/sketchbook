int POINT_COUNT = 200;
float[][] points = new float[POINT_COUNT][3];
float offset = 30.0;
float threshold = 400.0;
float depth = 1200.0;


void setup(){
  size(1200, 400, OPENGL);
  
  for(int i = 0; i < POINT_COUNT; i++){
    points[i][0] = random(width);
    points[i][1] = random(height);
    points[i][2] = random(depth);
  }
   strokeWeight(2);
}

void draw(){
  background(0); 
  
  float t = millis() * .0001;
  threshold = 400 + 100 * noise(t * 10);
  camera(width/2.0 + sin(t) * width/2.0, height/2,depth/2.0 + cos(t) * depth/2.0, // eyeX, eyeY, eyeZ
        width/2.0, height/2.0, depth/2.0, // centerX, centerY, centerZ
        0, 1, 0); // upX, upY, upZ

   for(int i = 0; i < points.length; i++){
     for(int j = 0; j < i; j++){
       float distance = dist(points[i][0], points[i][1], points[i][2], points[j][0], points[j][1], points[j][2]);
       if(distance < threshold){
         //closer is exponentially brighter
         float a  = pow(1/(distance/threshold + 1), 4) * 255;
         stroke(255, a);
         line(points[i][0], points[i][1], points[i][2], points[j][0], points[j][1], points[j][2]);
       }
     }
   }
}


