#ifndef Zeus_h
#define Zeus_h


#include "Arduino.h"
#include <ArduinoJson.h>

class Zeus
{
  public:
    Zeus();
    void   Read();
    String Address();
    String Command();
    String Status();

  private:
    StaticJsonDocument<200> _doc;
    const char*             _address = NULL;
    const char*             _command = NULL;
    String                  _status;
};

#endif
