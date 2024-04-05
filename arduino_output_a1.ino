/* Use a photoresistor (or photocell) to turn on an LED in the dark
   More info and circuit schematic: http://www.ardumotive.com/how-to-use-a-photoresistor-en.html
   Dev: Michalis Vasilakis // Date: 8/6/2015 // www.ardumotive.com */
   

//Constants
int dt = 2; // dt in milliseconds
unsigned long lastTime = 0;
int  LastValue = 0;
int  LastValue2 = 0;

float rate;
float rate2;

//Variables
int value1;				  // Store value from photoresistor (0-1023)
int value2;				  // Store value from photoresistor (0-1023)


void setup(){
 pinMode(A1, INPUT);// Set pResistor - A0 pin as an input
 Serial.begin(9600);
}

void loop(){

    //used for proper time delay/smapling time
    if (millis() - lastTime  >= dt)   // wait for dt milliseconds
      {
        
        lastTime = millis();
        //read photoresistor values
        value1 = analogRead(A0);
        value2 = analogRead(A1);
        //calculate rate of change
        rate = (value1 - LastValue) / dt;
        rate2 = (value2 - LastValue2) / dt; 
        //store last number to calculate rate
        LastValue = value1;
        LastValue2 = value2; 
        //print all the values and add special character and new line
        Serial.print(value2);
        Serial.print(",");             
        Serial.print(rate2);
        Serial.print('\n');

      }


  
}