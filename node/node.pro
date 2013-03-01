TEMPLATE = lib

nodelib.commands += \
	echo "Building node binaries..."; \
	#
	# Test for binaries.
	#
	`type node-gyp >/dev/null 2>&1` || exit 1; \
	#
	# Checkout the V8 git repository if it hasn't been yet.
	#
	node-gyp configure build; \
	echo "Done building node binaries.";
	
nodelib.target = n

QMAKE_EXTRA_TARGETS += nodelib

PRE_TARGETDEPS += n

QMAKE_POST_LINK = rm libnode*

spiis.path = ../SPII
spiis.commands += mkdir -p ../SPII; cp build/Release/*.node ../SPII
INSTALLS += spiis
