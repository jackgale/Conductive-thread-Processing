/* Processing code for this example*/
// Graphing sketch


// This program takes ASCII-encoded strings
// from the serial port at 9600 baud and graphs them. It expects values in the
// range 0 to 1023, followed by a newline, or newline and carriage return

// Created 20 Apr 2005
// Updated 18 Jan 2008
// by Tom Igoe
// This example code is in the public domain.

import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph
float colorz;

void setup () {
  // set the window size: 
  size(800, 200);
  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the second port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[1].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[7], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set inital background:
  background(0);
}
void draw () {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  println(inString);
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // map to the screen height:
    float inByte = float(inString);
    inByte = map(inByte, 800, 950, 0, height);

    colorz = map(inByte, 0,height, 0,125);
    // draw the line:  
    stroke(colorz, 255-colorz, colorz);    
    line(xPos, height, xPos, 0+ inByte);

    // at the edge of the screen, go back to the beginning:
    if (xPos >= width) {
      xPos = 0;
      
      background(0);
    } else {
      // increment the horizontal position:
      xPos++;
    }
  }
}