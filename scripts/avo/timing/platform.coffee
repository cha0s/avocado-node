
config = require 'avo/config'

exports.augment = (Timing) ->

	lastTime = 0
	global.requestAnimationFrame = (callback, element) ->
		currTime = new Date().getTime()
		
		timeToCall = Math.max(
			0
			(1000 / config.get 'rendersPerSecondTarget') - (currTime - lastTime)
		)
		
		lastTime = currTime + timeToCall
		
		setTimeout(
			-> callback lastTime
			timeToCall
		)
	
	global.cancelAnimationFrame = (handle) -> clearTimeout handle
