---
title: Blink 
nav_order: 10
---

# BLINK 


## Requirements

* [Install Python](/python)
* [Install arduino-cli and configure](/arduino.md)

## Purpose

To test and document the interface between an Arduino board and Python using the Serial port.

## [Repository]( https://github.com/sfawcett123/dcc/tree/main/python/blink)

## Expected Results

* Run the 'arduino-cli board list' to get the boards port.
* Edit the script to input the PORT
* run the script `python3 blink.py`
	*  Note the RX light on the Arduinio board blinks when the python program transmits data
	
