import com.francisli.processing.http.*;
import processing.serial.*;
Serial Arduino;

HttpClient myClient;
int lastMillis, curMillis;
int DELTA = 5000; //delay between calls
int lastDonated = 0; //last info from the request
int currentDonation = 0; //highest value so far

void setup(){
  println(Serial.list());
  lastMillis = 0;
  myClient = new HttpClient(this, "www.kickstarter.com");
  Arduino = new Serial(this, Serial.list()[0], 9600);
}

void makeRequest(){
  myClient.GET("/projects/search.json?search=&term=Job+Hunters+Season+Two");
}

int getDonatedAmount(String htmlBlock){
  String pattern = "\\$\\d*,?\\d*";
  String[] m = match(htmlBlock, pattern);
  String moneyString = m[0];
  moneyString = moneyString.substring(1); //ditch the $
  moneyString = moneyString.replaceAll(",", "");
  return int(moneyString);
}

boolean amountHasChanged(int currentAmt){
  if(currentAmt > lastDonated){
    lastDonated = currentAmt;
    println("here");
    return true;
  }
  return false;
}

void responseReceived(HttpRequest request, HttpResponse response) {
  if(response.statusCode == 200){
    JSONObject results = response.getContentAsJSONObject();
    JSONObject project = results.get("projects");
    JSONObject htmlBlock = project.get(0);
    lastDonated = getDonatedAmount(htmlBlock.get("card_html").stringValue());
    println(lastDonated);
  }
  
}

boolean totalHasIncreased(){
  if(lastDonated > currentDonation){
    currentDonation = lastDonated;
    return true;
  }
  
  return false;
}

void draw(){
  curMillis = millis();
  
  if(curMillis - lastMillis >= DELTA){
    makeRequest();
    if(totalHasIncreased()){
      Arduino.write('1');
    }
    lastMillis = curMillis;
  } 
}


