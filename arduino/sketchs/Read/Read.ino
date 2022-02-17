#include <LiquidCrystal.h>

unsigned long myTime;
const int rs = 12, en = 11, d4 = 37, d5 = 35, d6 = 33, d7 = 31;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
}

void loop() {
  myTime = millis();

  if (Serial.available() > 0 ) {

       lcd.setCursor(0, 0);
       String str = Serial.readString();
       lcd.print( "rx: "  + str  );

       lcd.setCursor(0, 1);
       Serial.println( myTime);                   // Send Time Back to USB 
       lcd.print( "tx: "  + String( myTime )  ); // Set a new Time
  }
}
