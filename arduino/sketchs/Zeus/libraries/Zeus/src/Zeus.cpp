
#include "Arduino.h"
#include "Zeus.h"

Zeus::Zeus()
{
    
}

void Zeus::Read()
{
  if (Serial.available() > -1 ) {
      String str = Serial.readString();
      DeserializationError error = deserializeJson( _doc, str );

      if (error) {
        _status = error.f_str();
      }

      _address = _doc["address"];
      _command = _doc["command"];
      _status = "Good";
  }
  _status = "No Data Found";
}

String Zeus::Address()
{
  return _address;
}

String Zeus::Command()
{
  return _command;
}

String Zeus::Status()
{
  return _status;
}