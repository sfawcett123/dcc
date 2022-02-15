#include <LiquidCrystal.h>
#include <NmraDcc.h>
#include <Zeus.h>

unsigned long myTime;
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);
Zeus zeus ;

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
}

void loop() {
  zeus.Read();

  lcd.setCursor(0, 0);
  lcd.print( "rx:  Installed ");

  lcd.setCursor(0, 1);
  lcd.print( "A:"  + zeus.Address()   );

  lcd.setCursor(6, 1);
  lcd.print( "C:"  + zeus.Command()   );

  lcd.setCursor(13, 1);
  lcd.print( "R:"  + zeus.Status()   );
  
  Serial.println( zeus.Status() );                   // Send Time Back to USB 

}
