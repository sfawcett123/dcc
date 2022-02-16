# Zeus Prototype

## Libraries
1. [NMRA DCC](https://github.com/mrrwa/NmraDcc)
1. [Arduino JSON](https://github.com/bblanchon/ArduinoJson)
1. [Liquid Crystal](https://github.com/arduino-libraries/LiquidCrystal)

## Setup

set the BOARD variable manually or use this command

```
export BOARD=$( arduino-cli board list --format json | jq -r '.[] | select( .port.address |  contains("/dev/cu.usbmodem") ) | .port.address' )
export CORE=$(  arduino-cli board list --format json | jq -r '.[] | select( .port.address |  contains("/dev/cu.usbmodem") ) | .matching_boards[0].fqbn' )
```

set up the configuration and import libraries

```
make config
make all install
```


