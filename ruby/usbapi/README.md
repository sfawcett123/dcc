# USB API

USBAPI is a simple API which will provide:

1. A list of connected Arduino boards
2. Read the output from the Arduino boards into a queue
3. Push input from a Queue into the Arduino board

## Versions & Dependancies
|Component|Version|
|---------|-------|
| ruby    | 2.7.0 |
|sqlite3	|3.32.3 |
|aduino-cli| 0.20.2 |


## Background Task List

1. Create a call that returns a list of connected Arduino boards, key by serial number
	2. Store the board list and periodically update its status ( online / offline )
	3. Identify which board is connected to which port and store that information

## URL list

1. Provide a JSON response giving a list of boards
	2. 	GET \<hostname>/usbs	
2. Provide a JSON response POPPING last message from board
	3. GET \<hostname>/arduino/<board>	
3. Provide a JSON action PUSHING a a message to a board
	4. PUT \<hostname>/arduino/<board>/message	
	

## Assistance

### Add Columns to tables
     rails g migration add_fields_to_usb label:string
     rails db:migrate
