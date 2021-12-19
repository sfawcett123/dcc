---
layout: default
title: LCD
nav_order: 20
parent: Experiments
---

# Liquid Crystal Display 
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Requirements

* [Install Python](/python)
* [Install arduino-cli and configure](/arduino.md)


## Purpose

It is a pretty simple task to wire a LCD display to an Arduino board and display a "Hello World" message, but I want to be able to send messages from my Python code to the Arduino board and display that message on the LCD.

Arduino give a simple example on how to wire a standard 16x2 LCD and display "Hello World" 
[Arduino Simple Example](https://www.arduino.cc/en/Tutorial/LibraryExamples/HelloWorld) this will be the first step we implement.


## Repositories
* [Python Code]( https://github.com/sfawcett123/dcc/tree/main/python/simple-lcd)
* [Sketch]()

## Process

* Run the 'arduino-cli board list' to get the boards port.
* Edit the Python code to input the PORT
* Deploy the Sketch to the Arduino Board
* Wire the LCD to the Arduino
	* [Arduino Simple Example](https://www.arduino.cc/en/Tutorial/LibraryExamples/HelloWorld) 
* run the script `python3 simple-lcd.py`
	
