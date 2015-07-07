import penner.easing.*;

int POINT_COUNT = 200;
float[][] position;
float[][] current;
float[][] target;
float offset = 30.0;
float threshold = 800.0;
float depth = 1200.0;

int time = 0;
float duration = 800;


boolean capture = true;

void setup(){
  size(4320, 1080, OPENGL);
  
  position = generateRandomPoints(POINT_COUNT);
  current = new float[POINT_COUNT][3];
  for(int i = 0; i < POINT_COUNT; i++){
       current[i][0] = position[i][0];
       current[i][1] = position[i][1];
       current[i][2] = position[i][2];
   }
  
  target = generateRandomPoints(POINT_COUNT);
  
  strokeWeight(4);
  frameRate(30);
}

void draw(){
  background(0); 
  
  float t = millis() * .00005;
  threshold = 1200 + (sin(t) * 800) * noise(t * 10);
  camera( sin(t) * width, sin(t) * height, cos(t) * depth, // eyeX, eyeY, eyeZ
        0, 0, 0, // centerX, centerY, centerZ
        0, 1, 0); // upX, upY, upZ
        
  for(int i = 0; i < position.length; i++){
      current[i][0] = clamp(Quint.easeOut(time, position[i][0], target[i][0], duration), -width, width);
      current[i][1] = clamp(Quint.easeOut(time, position[i][1], target[i][1], duration), -height, height);
      current[i][2] = clamp(Quint.easeOut(time, position[i][2], target[i][2], duration), -depth, depth);
  }

   for(int i = 0; i < position.length; i++){
     for(int j = 0; j < i; j++){
       float distance = dist(current[i][0], current[i][1], current[i][2], current[j][0], current[j][1], current[j][2]);
       if(distance < threshold){
         //closer is exponentially brighter
         float a  = pow(1/(distance/threshold + 1), 3) * 255;
         stroke(255, a);
         line(current[i][0], current[i][1], current[i][2], current[j][0], current[j][1], current[j][2]);
       }
     }
   }
   
//   stroke(255, 0, 0);
//   noFill();
//   box(width/2, height/2, depth/2);
//   
   if(time < duration){
     time++;
   }else{
     for(int i = 0; i < POINT_COUNT; i++){
       position[i][0] = current[i][0];
       position[i][1] = current[i][1];
       position[i][2] = current[i][2];
     }
     target=generateRandomPoints(POINT_COUNT);
     time = 0;
   }
   
    if(capture){
      saveFrame("/Volumes/HD_2/Designer_Preview/4320x1080/shifting_3d_lissajous_thick/####.tif");
     if(frameCount >= 30 * 60 * 5){
       exit();
     }
   }
}


float[][] generateRandomPoints(int count){
  float[][] pts = new float[count][3];
  for(int i = 0; i < count; i++){
    pts[i][0] = random(-width, width);
    pts[i][1] = random(-height, height);
    pts[i][2] = random(-depth, depth);
  }
  return pts;
}

float clamp(float input, float min, float max){
  float out = input;
  if(input < min){
    out = min;
  }if(input > max){
    out = max;
  }
  
  return out;
}



