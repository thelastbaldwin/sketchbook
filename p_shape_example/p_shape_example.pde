PShape circle;

void setup(){
  
  size(600, 600, OPENGL);
  circle = createShape(ELLIPSE, -150, -150, 300, 300);
  println(circle.getVertexCount());
  for(int i = 0; i < circle.getVertexCount(); i++){
    println("circle[" + i + "] = " + circle.getVertex(i));
  }
}

void draw(){
  background(211);
  translate(300,300);
  
  shape(circle);
}
