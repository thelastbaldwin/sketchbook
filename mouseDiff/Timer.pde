// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-5: Object-oriented timer

class Timer {
 
  int savedTime; // When Timer started
  int totalTime; // How long Timer should last
  boolean isFinished, isRunning;
  
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
    isFinished = false;
  }
  
  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
    isRunning = true; 
  }
  
  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if ((passedTime > totalTime) && isRunning) {
      isFinished =  true;
    } else {
      isFinished = false;
    }    
    return isFinished;
  }
  
  void reset(){
    isFinished = false;
    savedTime = 0;
    isRunning = false;
  }
}
