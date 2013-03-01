Config = require 'Config'

Core = require 'Core'
Core.CoreService.implementSpi Config.coreSpi
Core.coreService = new Core.CoreService()

# Probably need to straighten this out, still.
#Core.CoreService.setEngineRoot '../../../engine'
#Core.CoreService.setResourceRoot '../../../resource'

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

# SPI proxies.
require 'proxySpiis'

timeCounter = new Timing.Counter()

Main = class extends (require 'Main')

	constructor: ->
		
		super
		
		@stateChange = name: 'Initial', args: {}
	
	tick: ->
		
		Timing.TimingService.setElapsed timeCounter.current() / 1000
		
		super
		
main = new Main

# Log and exit on error.
main.on 'error', (error) ->

	message = if error.stack?
		error.stack
	else
		error.toString()
	console.error message
	
	main.quit 1

# Close out services and stop running on quit.
main.on 'quit', (code = 0) ->
	
	Sound.soundService.close()
	Timing.timingService.close()
	Graphics.graphicsService.close()
	Core.coreService.close()
	
	process.exit code

# Quit on interrupt (ctrl-c)
process.on 'SIGINT', ->
	
	main.quit()

# Go!
main.begin()
