# README

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


