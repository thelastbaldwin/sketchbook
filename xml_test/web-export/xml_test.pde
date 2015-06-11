XML xml;

void setup() {
  xml = loadXML("devs.xml");
  XML[] devs = xml.getChildren("dev");
  
  for (int i = 0; i < devs.length; i++) {
    String id = devs[i].getString("id");
    String name = devs[i].getContent();
    println(id + ", " + id + ", " + name);
  }
}

