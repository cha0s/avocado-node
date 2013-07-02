Config = require 'Config'

Core = require 'Core'
Core.CoreService.implementSpi Config.coreSpi
Core.coreService = new Core.CoreService()

path = require 'path'
Core.CoreService.setResourceRoot path.join process.cwd(), 'resource'

Graphics = require 'Graphics'
Graphics.GraphicsService.implementSpi Config.graphicsSpi
Graphics.graphicsService = new Graphics.GraphicsService()

Sound = require 'Sound'
Sound.SoundService.implementSpi Config.soundSpi
Sound.soundService = new Sound.SoundService()

Timing = require 'Timing'
Timing.TimingService.implementSpi Config.timingSpi
Timing.timingService = new Timing.TimingService()
Timing.ticksPerSecondTarget = Config.ticksPerSecondTarget
Timing.rendersPerSecondTarget = Config.rendersPerSecondTarget

# Monkey patches & SPI proxies.
require 'monkeyPatches'
require 'proxySpiis'


Main = require 'Main'

timeCounter = new Timing.Counter()

main = new Main()

main.on 'beforeTick', ->
	
	Timing.TimingService.setElapsed timeCounter.current() / 1000

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
	
	Sound.soundService.close()
	Timing.timingService.close()
	Graphics.graphicsService.close()
	Core.coreService.close()

# Quit on interrupt (ctrl-c)
process.on 'SIGINT', ->
	
	main.quit()

# Go!
main.begin()
