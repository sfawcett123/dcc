/**********************************************************************

DCC++ BASE STATION
COPYRIGHT (c) 2013-2016 Gregg E. Berman

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses

**********************************************************************/

// BEGIN BY INCLUDING THE HEADER FILES FOR EACH MODULE
 
#include "DCCpp_Uno.h"
#include "PacketRegister.h"
#include "CurrentMonitor.h"
#include "SerialCommand.h"
#include "Config.h"
#include "Comm.h"
#include <LiquidCrystal.h>
#include "global.h"

LiquidCrystal lcd(LCD_RS, LCD_EN, LCD_D4, LCD_D5, LCD_D6, LCD_D7);

void showConfiguration();

// SET UP COMMUNICATIONS INTERFACE - FOR STANDARD SERIAL, NOTHING NEEDS TO BE DONE

#if COMM_TYPE == 1
  byte mac[] =  MAC_ADDRESS;                                // Create MAC address (to be used for DHCP when initializing server)
  EthernetServer INTERFACE(ETHERNET_PORT);                  // Create and instance of an EnternetServer
#endif

// NEXT DECLARE GLOBAL OBJECTS TO PROCESS AND STORE DCC PACKETS AND MONITOR TRACK CURRENTS.
// NOTE REGISTER LISTS MUST BE DECLARED WITH "VOLATILE" QUALIFIER TO ENSURE THEY ARE PROPERLY UPDATED BY INTERRUPT ROUTINES

volatile RegisterList mainRegs(MAX_MAIN_REGISTERS);    // create list of registers for MAX_MAIN_REGISTER Main Track Packets
volatile RegisterList progRegs(2);                     // create a shorter list of only two registers for Program Track Packets

CurrentMonitor mainMonitor(CURRENT_MONITOR_PIN_MAIN,"<p2>");  // create monitor for current on Main Track
CurrentMonitor progMonitor(CURRENT_MONITOR_PIN_PROG,"<p3>");  // create monitor for current on Program Track

///////////////////////////////////////////////////////////////////////////////
// MAIN ARDUINO LOOP
///////////////////////////////////////////////////////////////////////////////

void loop(){
  
  SerialCommand::process();              // check for, and process, and new serial commands
  
  if(CurrentMonitor::checkTime()){      // if sufficient time has elapsed since last update, check current draw on Main and Program Tracks 
    mainMonitor.check();
    progMonitor.check();
  }

  
} // loop

///////////////////////////////////////////////////////////////////////////////
// INITIAL SETUP
///////////////////////////////////////////////////////////////////////////////

void setup(){  

  Serial.begin(115200);            // configure serial interface
  Serial.flush();

  lcd.begin(16, 2);
  lcd.setCursor(0, 0);
  lcd.print( "LCD Installed");

  #ifdef SDCARD_CS
    pinMode(SDCARD_CS,OUTPUT);
    digitalWrite(SDCARD_CS,HIGH);     // Deselect the SD card
  #endif

  pinMode(A5,INPUT);                                       // if pin A5 is grounded upon start-up, print system configuration and halt
  digitalWrite(A5,HIGH);
  if(!digitalRead(A5))
    showConfiguration();

  Serial.print("<iDCC++ BASE STATION FOR ARDUINO ");      // Print Status to Serial Line regardless of COMM_TYPE setting so use can open Serial Monitor and check configurtion 
  Serial.print(ARDUINO_TYPE);
  Serial.print(" / ");
  Serial.print(MOTOR_SHIELD_NAME);
  Serial.print(": V-");
  Serial.print(VERSION);
  Serial.print(" / ");
  Serial.print(__DATE__);
  Serial.print(" ");
  Serial.print(__TIME__);
  Serial.print(">");

  #if COMM_TYPE == 1
    #ifdef IP_ADDRESS
      Ethernet.begin(mac,IP_ADDRESS);           // Start networking using STATIC IP Address
    #else
      Ethernet.begin(mac);                      // Start networking using DHCP to get an IP Address
    #endif
    INTERFACE.begin();
  #endif
             
  SerialCommand::init(&mainRegs, &progRegs, &mainMonitor);   // create structure to read and parse commands from serial line

  Serial.print("<N");
  Serial.print(COMM_TYPE);
  Serial.print(": ");

  #if COMM_TYPE == 0
    Serial.print("SERIAL>");
  #elif COMM_TYPE == 1
    Serial.print(Ethernet.localIP());
    Serial.print(">");
  #endif
  
  // CONFIGURE TIMER_1 TO OUTPUT 50% DUTY CYCLE DCC SIGNALS ON OC1B INTERRUPT PINS
  
  // Direction Pin for Motor Shield Channel A - MAIN OPERATIONS TRACK
  // Controlled by Arduino 16-bit TIMER 1 / OC1B Interrupt Pin
  // Values for 16-bit OCR1A and OCR1B registers calibrated for 1:1 prescale at 16 MHz clock frequency
  // Resulting waveforms are 200 microseconds for a ZERO bit and 116 microseconds for a ONE bit with exactly 50% duty cycle

  #define DCC_ZERO_BIT_TOTAL_DURATION_TIMER1 3199
  #define DCC_ZERO_BIT_PULSE_DURATION_TIMER1 1599

  #define DCC_ONE_BIT_TOTAL_DURATION_TIMER1 1855
  #define DCC_ONE_BIT_PULSE_DURATION_TIMER1 927

  pinMode(DIRECTION_MOTOR_CHANNEL_PIN_A,INPUT);      // ensure this pin is not active! Direction will be controlled by DCC SIGNAL instead (below)
  digitalWrite(DIRECTION_MOTOR_CHANNEL_PIN_A,LOW);

  pinMode(DCC_SIGNAL_PIN_MAIN, OUTPUT);      // THIS ARDUINO OUPUT PIN MUST BE PHYSICALLY CONNECTED TO THE PIN FOR DIRECTION-A OF MOTOR CHANNEL-A

  bitSet(TCCR1A,WGM10);     // set Timer 1 to FAST PWM, with TOP=OCR1A
  bitSet(TCCR1A,WGM11);
  bitSet(TCCR1B,WGM12);
  bitSet(TCCR1B,WGM13);

  bitSet(TCCR1A,COM1B1);    // set Timer 1, OC1B (pin 10/UNO, pin 12/MEGA) to inverting toggle (actual direction is arbitrary)
  bitSet(TCCR1A,COM1B0);

  bitClear(TCCR1B,CS12);    // set Timer 1 prescale=1
  bitClear(TCCR1B,CS11);
  bitSet(TCCR1B,CS10);
    
  OCR1A=DCC_ONE_BIT_TOTAL_DURATION_TIMER1;
  OCR1B=DCC_ONE_BIT_PULSE_DURATION_TIMER1;
  
  pinMode(SIGNAL_ENABLE_PIN_MAIN,OUTPUT);   // master enable for motor channel A

  mainRegs.loadPacket(1,RegisterList::idlePacket,2,0);    // load idle packet into register 1    
      
  bitSet(TIMSK1,OCIE1B);    // enable interrupt vector for Timer 1 Output Compare B Match (OCR1B)    

  // CONFIGURE EITHER TIMER_0 (UNO) OR TIMER_3 (MEGA) TO OUTPUT 50% DUTY CYCLE DCC SIGNALS ON OC0B (UNO) OR OC3B (MEGA) INTERRUPT PINS
  
#ifdef ARDUINO_AVR_UNO      // Configuration for UNO
  
  // Directon Pin for Motor Shield Channel B - PROGRAMMING TRACK
  // Controlled by Arduino 8-bit TIMER 0 / OC0B Interrupt Pin
  // Values for 8-bit OCR0A and OCR0B registers calibrated for 1:64 prescale at 16 MHz clock frequency
  // Resulting waveforms are 200 microseconds for a ZERO bit and 116 microseconds for a ONE bit with as-close-as-possible to 50% duty cycle

  #define DCC_ZERO_BIT_TOTAL_DURATION_TIMER0 49
  #define DCC_ZERO_BIT_PULSE_DURATION_TIMER0 24

  #define DCC_ONE_BIT_TOTAL_DURATION_TIMER0 28
  #define DCC_ONE_BIT_PULSE_DURATION_TIMER0 14
  
  pinMode(DIRECTION_MOTOR_CHANNEL_PIN_B,INPUT);      // ensure this pin is not active! Direction will be controlled by DCC SIGNAL instead (below)
  digitalWrite(DIRECTION_MOTOR_CHANNEL_PIN_B,LOW);

  pinMode(DCC_SIGNAL_PIN_PROG,OUTPUT);      // THIS ARDUINO OUTPUT PIN MUST BE PHYSICALLY CONNECTED TO THE PIN FOR DIRECTION-B OF MOTOR CHANNEL-B

  bitSet(TCCR0A,WGM00);     // set Timer 0 to FAST PWM, with TOP=OCR0A
  bitSet(TCCR0A,WGM01);
  bitSet(TCCR0B,WGM02);
     
  bitSet(TCCR0A,COM0B1);    // set Timer 0, OC0B (pin 5) to inverting toggle (actual direction is arbitrary)
  bitSet(TCCR0A,COM0B0);

  bitClear(TCCR0B,CS02);    // set Timer 0 prescale=64
  bitSet(TCCR0B,CS01);
  bitSet(TCCR0B,CS00);
    
  OCR0A=DCC_ONE_BIT_TOTAL_DURATION_TIMER0;
  OCR0B=DCC_ONE_BIT_PULSE_DURATION_TIMER0;
  
  pinMode(SIGNAL_ENABLE_PIN_PROG,OUTPUT);   // master enable for motor channel B

  progRegs.loadPacket(1,RegisterList::idlePacket,2,0);    // load idle packet into register 1    
      
  bitSet(TIMSK0,OCIE0B);    // enable interrupt vector for Timer 0 Output Compare B Match (OCR0B)

#else      // Configuration for MEGA

  // Directon Pin for Motor Shield Channel B - PROGRAMMING TRACK
  // Controlled by Arduino 16-bit TIMER 3 / OC3B Interrupt Pin
  // Values for 16-bit OCR3A and OCR3B registers calibrated for 1:1 prescale at 16 MHz clock frequency
  // Resulting waveforms are 200 microseconds for a ZERO bit and 116 microseconds for a ONE bit with exactly 50% duty cycle

  #define DCC_ZERO_BIT_TOTAL_DURATION_TIMER3 3199
  #define DCC_ZERO_BIT_PULSE_DURATION_TIMER3 1599

  #define DCC_ONE_BIT_TOTAL_DURATION_TIMER3 1855
  #define DCC_ONE_BIT_PULSE_DURATION_TIMER3 927

  pinMode(DIRECTION_MOTOR_CHANNEL_PIN_B,INPUT);      // ensure this pin is not active! Direction will be controlled by DCC SIGNAL instead (below)
  digitalWrite(DIRECTION_MOTOR_CHANNEL_PIN_B,LOW);

  pinMode(DCC_SIGNAL_PIN_PROG,OUTPUT);      // THIS ARDUINO OUTPUT PIN MUST BE PHYSICALLY CONNECTED TO THE PIN FOR DIRECTION-B OF MOTOR CHANNEL-B

  bitSet(TCCR3A,WGM30);     // set Timer 3 to FAST PWM, with TOP=OCR3A
  bitSet(TCCR3A,WGM31);
  bitSet(TCCR3B,WGM32);
  bitSet(TCCR3B,WGM33);

  bitSet(TCCR3A,COM3B1);    // set Timer 3, OC3B (pin 2) to inverting toggle (actual direction is arbitrary)
  bitSet(TCCR3A,COM3B0);

  bitClear(TCCR3B,CS32);    // set Timer 3 prescale=1
  bitClear(TCCR3B,CS31);
  bitSet(TCCR3B,CS30);
    
  OCR3A=DCC_ONE_BIT_TOTAL_DURATION_TIMER3;
  OCR3B=DCC_ONE_BIT_PULSE_DURATION_TIMER3;
  
  pinMode(SIGNAL_ENABLE_PIN_PROG,OUTPUT);   // master enable for motor channel B

  progRegs.loadPacket(1,RegisterList::idlePacket,2,0);    // load idle packet into register 1    
      
  bitSet(TIMSK3,OCIE3B);    // enable interrupt vector for Timer 3 Output Compare B Match (OCR3B)    
  
#endif

} // setup

///////////////////////////////////////////////////////////////////////////////
// DEFINE THE INTERRUPT LOGIC THAT GENERATES THE DCC SIGNAL
///////////////////////////////////////////////////////////////////////////////

// The code below will be called every time an interrupt is triggered on OCNB, where N can be 0 or 1. 
// It is designed to read the current bit of the current register packet and
// updates the OCNA and OCNB counters of Timer-N to values that will either produce
// a long (200 microsecond) pulse, or a short (116 microsecond) pulse, which respectively represent
// DCC ZERO and DCC ONE bits.

// These are hardware-driven interrupts that will be called automatically when triggered regardless of what
// DCC++ BASE STATION was otherwise processing.  But once inside the interrupt, all other interrupt routines are temporarily diabled.
// Since a short pulse only lasts for 116 microseconds, and there are TWO separate interrupts
// (one for Main Track Registers and one for the Program Track Registers), the interrupt code must complete
// in much less than 58 microsends, otherwise there would be no time for the rest of the program to run.  Worse, if the logic
// of the interrupt code ever caused it to run longer than 58 microsends, an interrupt trigger would be missed, the OCNA and OCNB
// registers would not be updated, and the net effect would be a DCC signal that keeps sending the same DCC bit repeatedly until the
// interrupt code completes and can be called again.

// A significant portion of this entire program is designed to do as much of the heavy processing of creating a properly-formed
// DCC bit stream upfront, so that the interrupt code below can be as simple and efficient as possible.

// Note that we need to create two very similar copies of the code --- one for the Main Track OC1B interrupt and one for the
// Programming Track OCOB interrupt.  But rather than create a generic function that incurrs additional overhead, we create a macro
// that can be invoked with proper paramters for each interrupt.  This slightly increases the size of the code base by duplicating
// some of the logic for each interrupt, but saves additional time.

// As structured, the interrupt code below completes at an average of just under 6 microseconds with a worse-case of just under 11 microseconds
// when a new register is loaded and the logic needs to switch active register packet pointers.

// THE INTERRUPT CODE MACRO:  R=REGISTER LIST (mainRegs or progRegs), and N=TIMER (0 or 1)

#define DCC_SIGNAL(R,N) \
  if(R.currentBit==R.currentReg->activePacket->nBits){    /* IF no more bits in this DCC Packet */ \
    R.currentBit=0;                                       /*   reset current bit pointer and determine which Register and Packet to process next--- */ \   
    if(R.nRepeat>0 && R.currentReg==R.reg){               /*   IF current Register is first Register AND should be repeated */ \
      R.nRepeat--;                                        /*     decrement repeat count; result is this same Packet will be repeated */ \
    } else if(R.nextReg!=NULL){                           /*   ELSE IF another Register has been updated */ \
      R.currentReg=R.nextReg;                             /*     update currentReg to nextReg */ \
      R.nextReg=NULL;                                     /*     reset nextReg to NULL */ \
      R.tempPacket=R.currentReg->activePacket;            /*     flip active and update Packets */ \        
      R.currentReg->activePacket=R.currentReg->updatePacket; \
      R.currentReg->updatePacket=R.tempPacket; \
    } else{                                               /*   ELSE simply move to next Register */ \
      if(R.currentReg==R.maxLoadedReg)                    /*     BUT IF this is last Register loaded */ \
        R.currentReg=R.reg;                               /*       first reset currentReg to base Register, THEN */ \
      R.currentReg++;                                     /*     increment current Register (note this logic causes Register[0] to be skipped when simply cycling through all Registers) */ \
    }                                                     /*   END-ELSE */ \
  }                                                       /* END-IF: currentReg, activePacket, and currentBit should now be properly set to point to next DCC bit */ \
                                                          \
  if(R.currentReg->activePacket->buf[R.currentBit/8] & R.bitMask[R.currentBit%8]){     /* IF bit is a ONE */ \
    OCR ## N ## A=DCC_ONE_BIT_TOTAL_DURATION_TIMER ## N;                               /*   set OCRA for timer N to full cycle duration of DCC ONE bit */ \
    OCR ## N ## B=DCC_ONE_BIT_PULSE_DURATION_TIMER ## N;                               /*   set OCRB for timer N to half cycle duration of DCC ONE but */ \
  } else{                                                                              /* ELSE it is a ZERO */ \
    OCR ## N ## A=DCC_ZERO_BIT_TOTAL_DURATION_TIMER ## N;                              /*   set OCRA for timer N to full cycle duration of DCC ZERO bit */ \
    OCR ## N ## B=DCC_ZERO_BIT_PULSE_DURATION_TIMER ## N;                              /*   set OCRB for timer N to half cycle duration of DCC ZERO bit */ \
  }                                                                                    /* END-ELSE */ \ 
                                                                                       \ 
  R.currentBit++;                                         /* point to next bit in current Packet */  
  
///////////////////////////////////////////////////////////////////////////////

// NOW USE THE ABOVE MACRO TO CREATE THE CODE FOR EACH INTERRUPT

ISR(TIMER1_COMPB_vect){              // set interrupt service for OCR1B of TIMER-1 which flips direction bit of Motor Shield Channel A controlling Main Track
  DCC_SIGNAL(mainRegs,1)
}

#ifdef ARDUINO_AVR_UNO      // Configuration for UNO

ISR(TIMER0_COMPB_vect){              // set interrupt service for OCR1B of TIMER-0 which flips direction bit of Motor Shield Channel B controlling Prog Track
  DCC_SIGNAL(progRegs,0)
}

#else      // Configuration for MEGA

ISR(TIMER3_COMPB_vect){              // set interrupt service for OCR3B of TIMER-3 which flips direction bit of Motor Shield Channel B controlling Prog Track
  DCC_SIGNAL(progRegs,3)
}

#endif


///////////////////////////////////////////////////////////////////////////////
// PRINT CONFIGURATION INFO TO SERIAL PORT REGARDLESS OF INTERFACE TYPE
// - ACTIVATED ON STARTUP IF SHOW_CONFIG_PIN IS TIED HIGH 

void showConfiguration(){

  int mac_address[]=MAC_ADDRESS;

  Serial.print("\n*** DCC++ CONFIGURATION ***\n");

  Serial.print("\nVERSION:      ");
  Serial.print(VERSION);
  Serial.print("\nCOMPILED:     ");
  Serial.print(__DATE__);
  Serial.print(" ");
  Serial.print(__TIME__);

  Serial.print("\nARDUINO:      ");
  Serial.print(ARDUINO_TYPE);

  Serial.print("\n\nMOTOR SHIELD: ");
  Serial.print(MOTOR_SHIELD_NAME);
  
  Serial.print("\n\nDCC SIG MAIN: ");
  Serial.print(DCC_SIGNAL_PIN_MAIN);
  Serial.print("\n   DIRECTION: ");
  Serial.print(DIRECTION_MOTOR_CHANNEL_PIN_A);
  Serial.print("\n      ENABLE: ");
  Serial.print(SIGNAL_ENABLE_PIN_MAIN);
  Serial.print("\n     CURRENT: ");
  Serial.print(CURRENT_MONITOR_PIN_MAIN);

  Serial.print("\n\nDCC SIG PROG: ");
  Serial.print(DCC_SIGNAL_PIN_PROG);
  Serial.print("\n   DIRECTION: ");
  Serial.print(DIRECTION_MOTOR_CHANNEL_PIN_B);
  Serial.print("\n      ENABLE: ");
  Serial.print(SIGNAL_ENABLE_PIN_PROG);
  Serial.print("\n     CURRENT: ");
  Serial.print(CURRENT_MONITOR_PIN_PROG);

  
  Serial.print("\n\nINTERFACE:    ");
  #if COMM_TYPE == 0
    Serial.print("SERIAL");
  #elif COMM_TYPE == 1
    Serial.print(COMM_SHIELD_NAME);
    Serial.print("\nMAC ADDRESS:  ");
    for(int i=0;i<5;i++){
      Serial.print(mac_address[i],HEX);
      Serial.print(":");
    }
    Serial.print(mac_address[5],HEX);
    Serial.print("\nPORT:         ");
    Serial.print(ETHERNET_PORT);
    Serial.print("\nIP ADDRESS:   ");

    #ifdef IP_ADDRESS
      Ethernet.begin(mac,IP_ADDRESS);           // Start networking using STATIC IP Address
    #else
      Ethernet.begin(mac);                      // Start networking using DHCP to get an IP Address
    #endif     
    
    Serial.print(Ethernet.localIP());

    #ifdef IP_ADDRESS
      Serial.print(" (STATIC)");
    #else
      Serial.print(" (DHCP)");
    #endif
  
  #endif
  Serial.print("\n\nPROGRAM HALTED - PLEASE RESTART ARDUINO");

  while(true);
}

///////////////////////////////////////////////////////////////////////////////




