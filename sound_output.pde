/**
 * Processing Sound Library, Example 1
 *
 * Five sine waves are layered to construct a cluster of frequencies.
 * This method is called additive synthesis. Use the mouse position
 * inside the display window to detune the cluster.
 */

import processing.sound.*;
import processing.serial.*;


Serial myPort;

SinOsc[] sineWaves; // Array of sines
float[] sineFreq; // Array of frequencies
int numSines = 1; // Number of oscillators to use

void setup() {
  //window setup, not sure if it works without it. 
  size(640, 360);
  background(255);

  sineWaves = new SinOsc[numSines]; // Initialize the oscillators
  sineFreq = new float[numSines]; // Initialize array for Frequencies
  myPort = new Serial(this,"COM4", 9600); // Initialize Port

  for (int i = 0; i < numSines; i++) {
    // Calculate the amplitude for each oscillator
    float sineVolume = (1.0 / numSines) / (i + 1);
    // Create the oscillators
    sineWaves[i] = new SinOsc(this);
    // Start Oscillators
    sineWaves[i].play();
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);
  }
}

void draw() {
  //check if seial is avaliable
  while (myPort.available() > 0) {
    //read serial
    String inStr = myPort.readStringUntil('\n');    
    if (inStr != null) {
        //trim the inputted string 
        inStr = trim(inStr);
        //separate the incoming values. [0] is intencity and [1] is a rate of change. 
        float[] trimStr = float(split(inStr, ','));
        

  
    
    //Map intencity from 0 to 1
     
      float yoffset = map(trimStr[0], -3, 3, 0, 1);
      //modify frquency values, add phase shift using a rate of change value
      float frequency = pow(100, yoffset) + abs(trimStr[1]*10);
      //detune according to frequency
      float detune =map(trimStr[1],-3, 3, -0.5, 1); 
      println(trimStr[1]);
      //used for one oscillator in this case 
      for (int i = 0; i < numSines; i++) {
        sineFreq[i] = frequency * (i + 1 * detune);
        // Set the frequencies for all oscillators
        sineWaves[i].freq(sineFreq[i]);
      }
    }
  }
}
