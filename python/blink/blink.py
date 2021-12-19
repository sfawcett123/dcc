import serial
import time

# Run "arduino-cli board list" to get a list of connected arduino boards and PORTS, then enter the port details here.
PORT='/dev/cu.usbmodem141301'

for i in range(10):
    with serial.Serial( PORT , 9800, timeout=1) as ser:
        time.sleep(0.5)
        ser.write(b'H')   # send the pyte string 'H'
        time.sleep(0.5)   # wait 0.5 seconds
        ser.write(b'L')   # send the byte string 'L'
