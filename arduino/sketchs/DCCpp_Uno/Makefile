LIBRARIES:=LiquidCrystal ArduinoJson NmraDcc

BOARD  := $(shell arduino-cli board list --format json | jq -r '.[] | select( .port.address |  contains("/dev/cu.usbmodem") ) | .port.address' )
CORE   := $(shell arduino-cli board list --format json | jq -r '.[] | select( .port.address |  contains("/dev/cu.usbmodem") ) | .matching_boards[0].fqbn' )
SKETCH := DCCpp_Uno

.PHONY: install $(addprefix install_,$(LIBRARIES))
install : $(addprefix install_,$(LIBRARIES))

.PHONY: uninstall $(addprefix uninstall_,$(LIBRARIES))
uninstall : $(addprefix uninstall_,$(LIBRARIES))

config:
	arduino-cli config init --dest-dir ${PWD} --overwrite
	arduino-cli config set directories.user ${PWD}
	grep -qxF 'arduino-cli.yaml' .gitignore || echo 'arduino-cli.yaml' >> .gitignore

compile:
	arduino-cli compile -b $(CORE) ${SKETCH}.ino

deploy:
	arduino-cli upload -b $(CORE) -p $(BOARD)

monitor:
	arduino-cli monitor -p $(BOARD) -c baudrate=115200

define LIBRARY_template
$(1): $$($(1)_OBJS)

install_$(1): $(1)
	arduino-cli lib install $(1)
	grep -qxF '$(1)' .gitignore || echo '$(1)' >> .gitignore

uninstall_$(1): $(1)
	arduino-cli lib uninstall $(1)

endef

$(foreach lib,$(LIBRARIES),$(eval $(call LIBRARY_template,$(lib))))

