
add_custom_command(
	
	OUTPUT
		__core.node
		__graphics.node
		__sound.node
		__timing.node

	COMMAND node-gyp configure build
	
	COMMAND mkdir -p ../SPII
	COMMAND cp build/Release/__core.node ../SPII
	COMMAND cp build/Release/__graphics.node ../SPII
	COMMAND cp build/Release/__sound.node ../SPII
	COMMAND cp build/Release/__timing.node ../SPII
	
	WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}

)

add_custom_target(avocado-node-node ALL
	DEPENDS
		__core.node
		__graphics.node
		__sound.node
		__timing.node
)
