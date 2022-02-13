#include <LiquidCrystal.h>

unsigned long myTime;
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
  lcd.print("Milli Second");
  pinMode(LED_BUILTIN, OUTPUT);
}
void loop() {
  Serial.print("Time: ");
  myTime = millis();

  lcd.setCursor(0, 1);
  Serial.println(myTime);            // prints time since program started
  lcd.print( myTime );
  digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);                       // wait a second so as not to send massive amounts of data
  digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);                       // wait for a second
}
