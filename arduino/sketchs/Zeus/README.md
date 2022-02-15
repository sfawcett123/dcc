# Zeus Prototype

## Libraries
1. [NMRA DCC](https://github.com/mrrwa/NmraDcc)
1. [Arduino JSON](https://github.com/bblanchon/ArduinoJson)
1. [Liquid Crystal](https://github.com/arduino-libraries/LiquidCrystal)

## Setup

set the BOARD variable manually or use this command

```
export BOARD=$( arduino-cli board list --format json | jq -r '.[].port | select( .address |  contains("/dev/cu.usbmodem") ) | .address' )
```

set up the configuration and import libraries

```
make config
make all install
```


