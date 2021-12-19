---
title: Arduino 
nav_order: 1
---

# Arduino 

([Arduino home page](https://www.arduino.cc/))

Arduino is an open-source electronics platform based on easy-to-use hardware and software. Arduino boards are able to read inputs and turn it into an output.

## Requirements

 * [Arduino ClI ](https://arduino.github.io/arduino-cli/0.20/installation/)

## Configure

### Boards
We will first need a list of boards, this will install some  missing builtins when first run. You should connect your arduino board before running this command:

```
❯ arduino-cli board list

Port                            Protocol Type              Board Name                FQBN             Core
/dev/cu.Bluetooth-Incoming-Port serial   Unknown
/dev/cu.DOSSSoundBox-SerialPort serial   Unknown
/dev/cu.usbmodem14201           serial   Serial Port (USB) Arduino Mega or Mega 2560 arduino:avr:mega arduino:avr
```

### Cores
Here you can see I have an Arduino Mega attached and I now need to make sure I have the right cores installed with the command ```arduino-cli core list```

To do this I need to run the command `arduino-cli core install <CORE>` where the core is from the previous command.

```
❯ arduino-cli core install arduino:avr

Downloading packages...
arduino:avr-gcc@7.3.0-atmel3.6.1-arduino7 downloaded
arduino:avrdude@6.3.0-arduino17 downloaded
arduino:arduinoOTA@1.3.0 downloaded
arduino:avr@1.8.4 downloaded
Installing arduino:avr-gcc@7.3.0-atmel3.6.1-arduino7...
arduino:avr-gcc@7.3.0-atmel3.6.1-arduino7 installed
Installing arduino:avrdude@6.3.0-arduino17...
arduino:avrdude@6.3.0-arduino17 installed
Installing arduino:arduinoOTA@1.3.0...
arduino:arduinoOTA@1.3.0 installed
Installing platform arduino:avr@1.8.4...
Configuring platform....
Platform arduino:avr@1.8.4 installed
```

Re-running the core list command will now show the version of the core. You will need to repeat this for different Arduino boards.

## Compile

In my arduino/sketches directory I have included the [Blink](https://www.arduino.cc/en/Tutorial/BuiltInExamples/Blink) sketch this can be used to test your connectivity and board.

### Get the board type
You will need the Fully Qualified Board Name (FQBN) to compile your sketch. this is given by the ```arduino board list``` command.

```
❯ arduino-cli  board list
Port                            Protocol Type              Board Name                FQBN             Core
/dev/cu.Bluetooth-Incoming-Port serial   Unknown
/dev/cu.DOSSSoundBox-SerialPort serial   Unknown
/dev/cu.usbmodem14201           serial   Serial Port (USB) Arduino Mega or Mega 2560 arduino:avr:mega arduino:avr
```

### Compile the sketch

Now you can compile the sketch: 

```
❯ arduino-cli compile -b arduino:avr:mega Blink
Sketch uses 1536 bytes (0%) of program storage space. Maximum is 253952 bytes.
Global variables use 9 bytes (0%) of dynamic memory, leaving 8183 bytes for local variables. Maximum is 8192 bytes.
```

## Upload

### Uploading the Sketch
The first step is to get your board list again then we can run the command ```arduino-cli upload -b <FQBN> -p <PORT>```.

```
arduino-cli upload -b arduino:avr:mega -p /dev/cu.usbmodem14201
```




