//manually/randomly pick a pixel from an image and get the color from it
PImage avatar;
color[] uniques;
int i;

//text
PFont droidSansMono; 
String s;

void setup(){
  size(640, 480);
  i = 0;
  avatar = loadImage("avatar.jpg");
  avatar.loadPixels();
  uniques = getUniqueColors(avatar.pixels);
  println(uniques.length + " colors");
  frameRate(30);
  
  droidSansMono = loadFont("DroidSansMono-48.vlw");
textFont(droidSansMono);
}

void draw(){
  background(211);
  noFill();
  strokeWeight(5);
  rect(25, 50, 256, 256);
  image(avatar, 25, 50);
  
  //rectangle for color  
  fill(uniques[i]);
  rect(350, 50, 256, 256);
  
  
  s = hex(uniques[i], 6);
  
  text("#" + s, 350, 370);
  
   i %= uniques.length;

}

color[] getUniqueColors(color[] colors){
  ArrayList uniques = new ArrayList(1);
  //separate out the unique colors from all the colors in an image
  //use an ArrayList because we don't know how many colors there will be
  for(int i = 0; i < colors.length; i++){
    if(!uniques.contains(colors[i])){
      uniques.add(colors[i]);
    }
  }
  
  int[] c = new int[uniques.size()];
  
  for(int i = 0; i < c.length; i++){
    c[i] = (Integer)uniques.get(i);
    c[i] = color(c[i]);
  }
  
  return c;
}

void keyPressed(){
  
  i++;
  println("uniques[i] = " + uniques[i]);
  println("s = # + " + s);
}

