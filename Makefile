ifndef VERBOSE
.SILENT:
endif

.PHONY:	mac
mac:
	$(eval export INSTALLER="brew install")
	$(eval export ARDUINO_CLI_PACKAGE="arduino-cli")


arduino:
	 sudo ${INSTALLER} ${ARDUINO_CLI_PACKAGE}	
