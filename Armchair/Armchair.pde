import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

//use 10 KOhm resistor-brown, black, orange

void setup(){
	size(400, 500);
	arduino = new Arduino(this, Arduino.list()[0], 57600);

	println(Arduino.list());
}

void draw()
{
	println(arduino.analogRead(0));
	background(255);

	//arm rests
	fill(100);
	quad(width/2-65, height/2-75, width/2-115, height/2-20, width/2-145, height/2-20, width/2-80, height/2-75);
	quad(width/2+65, height/2-75, width/2+115, height/2-20, width/2+145, height/2-20, width/2+80, height/2-75);
	fill(150);
	quad(width/2-110, height/2+25, width/2-60, height/2-50, width/2-65, height/2-65, width/2-115, height/2-20);
	quad(width/2+110, height/2+25, width/2+60, height/2-50, width/2+65, height/2-75, width/2+115, height/2-20);
	fill(120);
	quad(width/2-115, height/2-20, width/2-145, height/2-20, width/2-125, height/2+60, width/2-105, height/2+60);
	quad(width/2+115, height/2-20, width/2+145, height/2-20, width/2+125, height/2+60, width/2+105, height/2+60);

	//seat
	fill(100);
	quad(width/2-120, height/2+40, width/2+120, height/2+40, width/2+60, height/2-50, width/2-60, height/2-50);
	fill(120);
	quad(width/2-120, height/2+40, width/2+120, height/2+40, width/2+110, height/2+90, width/2-110, height/2+90);

	//back
	quad(width/2+60, height/2-50, width/2-60, height/2-50, width/2-70, height/2-100, width/2+70, height/2-100);
	fill(100);
	quad(width/2-70, height/2-100, width/2+70, height/2-100, width/2+50, height/2-110, width/2-50, height/2-110);

	//left front leg
	fill(80);
	quad(width/2+100, height/2+90, width/2+85, height/2+90, width/2+85, height/2+110, width/2+95, height/2+110);
	quad(width/2-100, height/2+90, width/2-85, height/2+90, width/2-85, height/2+110, width/2-95, height/2+110);
	fill(150);
	quad(width/2-85, height/2+90, width/2-85, height/2+110, width/2-82, height/2+107, width/2-80, height/2+90);
	quad(width/2+85, height/2+90, width/2+85, height/2+110, width/2+82, height/2+107, width/2+80, height/2+90);

	fill(100, 140, 200, 150);
	stroke(100, 140, 200);
	ellipse((width/2), (height/2)-70, (200-(arduino.analogRead(0)/6)), (200-(arduino.analogRead(0)/6)));
	ellipse((width/2), height/2, (250-(arduino.analogRead(1)/6)), (150-(arduino.analogRead(1)/6)));

	stroke(100);

	//top circle center
	line(width/2, height/2-60, width/2, height/2-80);
	line(width/2-10, height/2-70, width/2+10, height/2-70);

	//bottom circle center
	line(width/2, height/2+10, width/2, height/2-10);
	line(width/2-10, height/2, width/2+10, height/2);

	save("armchair.tiff");

}


