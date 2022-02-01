ifndef VERBOSE
.SILENT:
endif

.PHONY:	mac
mac:
	$(eval export INSTALLER="brew install")
	$(eval export ARDUINO_CLI_PACKAGE="arduino-cli")
	$(eval export MYSQL_PACKAGE="mysql")


arduino:
	 sudo ${INSTALLER} ${ARDUINO_CLI_PACKAGE}	

mysql:
	 sudo ${INSTALLER} ${MYSQL_PACKAGE}	
