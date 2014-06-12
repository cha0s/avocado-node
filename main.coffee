
spii.proxy() for spii in [
	Core = require 'avo/core'
	Graphics = require 'avo/graphics'
	Sound = require 'avo/sound'
	Timing = require 'avo/timing'
]

path = require 'path'
Core.CoreService.setExePath path.join process.cwd(), 'avocado-node'
Core.CoreService.setResourceRoot path.join process.cwd(), 'resource'

require 'avo/monkeyPatches'

Main = require 'avo/main'

main = new Main()

firstTime = Timing.TimingService.current()

main.on 'beforeTick', ->
	
	Timing.TimingService.setElapsed (Timing.TimingService.current() - firstTime) / 1000

# Log and exit on error.
main.on 'error', (error) ->
	
	message = if error.stack?
		error.stack
	else
		error.toString()
	console.error message
	
	main.quit()
	process.exit 1

# Close out services and stop running on quit.
main.on 'quit', (code = 0) ->
	
	Timing.timingService.close()
	Sound.soundService.close()
	Graphics.graphicsService.close()
	Core.coreService.close()
	
	process.exit 0

# Quit on interrupt (ctrl-c)
process.on 'SIGINT', ->
	
	main.quit()

# Go!
main.begin()
