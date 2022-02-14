---
title: LCD Simple Display 
nav_order: 20
layout: page
parent: Circuits
---

# LCD Simple Display 
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}


## References

1. <a name="REF_1"></a> [Arduino Example](https://www.arduino.cc/en/Tutorial/LibraryExamples/HelloWorld)
1. [HD44780 Data Sheet](https://www.digikey.co.uk/htmldatasheets/production/3361092/0/0/1/HD44780U-LCD-II-.pdf)
1. [Projects Using 44780]( https://www.best-microcontroller-projects.com/hitachi-hd44780.html)


## Introduction

The LiquidCrystal library allows you to control LCD displays that are compatible with the Hitachi HD44780 driver.

We are going to us a LCD display to show what is going on in the controller, without the need to send information back to the computer.

## Construction

Follow the instructions in [Reference](#REF_1) to wire up the LCD Display and test the connections.

## Pin Connections

| Display |Ref | Arduino | Purpose |
|---------|----|---------|---------|
|RS       |RS  | 12      | Selects Data or Instruction register  |
|Enable   |E   | 11      | Starts Data Write  |
|D4       |D4  | 5       | Data Transfer      |
|D5       |D5  | 4       | Data Transfer      |
|D6       |D6  | 3       | Data Transfer      |
|D7       |D7  | 2       | Data Transfer      |
|RW       |RW  | GND     | Selects Read or Write ( forced to Write ) |
|VSS      |VSS | GND     | Ground Supply      |
|VCC      |VCC | 5v      | Power Supply       |
|LED+     |A   | 5v (via 220 ohm Resistor     | Backlight Power      |
|LED-     |K   | GND     | Backlight Ground   |

## Diagram
![LCD](lcd.png)