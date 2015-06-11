import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
AudioPlayer player;
Minim minim;//audio context

int sensorVal;

void setup()
{
  minim = new Minim(this);
  player = minim.loadFile("Sister Christian.mp3", 2048);
  player.skip(60000);
  //player.play();

  arduino = new Arduino(this, Arduino.list()[0], 57600);

  println(Arduino.list());
}

void draw()
{
  //can use this to pinpoint where the song should start
  //println(player.position());
  sensorVal = arduino.analogRead(0);
  println(sensorVal);
  
  if(sensorVal > 500  && !player.isPlaying()){
    player.play();
  }
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}

void keyPressed(){
	//q key aborts the mission
	if(key == 'q'){
		stop();
	}	
}

