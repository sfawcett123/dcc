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
* Wire LCD to Arduino

## Purpose

It is a pretty simple task to wire a LCD display to an Arduino board and display a "Hello World" message, but I want to be able to send messages from my Python code to the Arduino board and display that message on the LCD.

## Repositories
* [Python]( https://github.com/sfawcett123/dcc/tree/main/python/simple-lcd)

## Process

* Run the 'arduino-cli board list' to get the boards port.
* Edit the script to input the PORT
* run the script `python3 simple-lcd.py`
	
