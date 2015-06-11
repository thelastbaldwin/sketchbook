import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
AudioPlayer sound;
Minim minim;//audio context

int sensorVal;
int previousMillis;
int mark;

void setup()
{
  minim = new Minim(this);
  sound = minim.loadFile("doorbell.wav", 512);

  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(7, Arduino.INPUT);
  
  previousMillis = 0;

  println(Arduino.list());
}

void draw()
{
  //can use this to pinpoint where the song should start
  //println(player.position());
  sensorVal = arduino.digitalRead(7);
  mark = millis();
  
  //if the sensor detects and signal and the sound is not already playing AND
  //at least 8 seconds have passed since the last triggering
  if(sensorVal == 1 && !sound.isPlaying() && mark - previousMillis >= 5000){
    sound.rewind();
    sound.play();
    previousMillis = mark;
  }
}

void stop()
{
  sound.close();
  minim.stop();
  super.stop();
}

void keyPressed(){
  //q key aborts the mission
  if(key == 'q'){
    stop();
  }  
}

