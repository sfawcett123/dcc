LIBRARIES:=LiquidCrystal ArduinoJson NmraDcc

.PHONY: all
all : $(LIBRARIES)

.PHONY: install $(addprefix install_,$(LIBRARIES))
install : $(addprefix install_,$(LIBRARIES))

.PHONY: uninstall $(addprefix uninstall_,$(LIBRARIES))
uninstall : $(addprefix uninstall_,$(LIBRARIES))

config:
	arduino-cli config init --dest-dir ${PWD} --overwrite
	arduino-cli config set directories.user ${PWD}
	grep -qxF 'arduino-cli.yaml' .gitignore || echo 'arduino-cli.yaml' >> .gitignore

compile:
	arduino-cli compile -b arduino:avr:mega Zeus.ino

deploy:
	arduino-cli upload -b arduino:avr:mega -p $(BOARD)

define LIBRARY_template
$(1): $$($(1)_OBJS)

install_$(1): $(1)
	arduino-cli lib install $(1)
	grep -qxF '$(1)' .gitignore || echo '$(1)' >> .gitignore

uninstall_$(1): $(1)
	arduino-cli lib uninstall $(1)

endef

$(foreach lib,$(LIBRARIES),$(eval $(call LIBRARY_template,$(lib))))

