extends Sprite3D

export var lyric = ""
export var flash = false
export var off = 0

func _ready():
	opacity = 0
	Settings.dict.ctotal += 1
	
	$ncol.translation.z = (Settings.dict.interpdist / 1000)
	$ncol.scale.z = (Settings.dict.interpdist / 100)
	
	$tween.interpolate_property(
		self, # node
		"translation:z", # property
		translation.z, # start value
		1, # end value
		2, # duration
		Tween.TRANS_LINEAR, # easing type
		Tween.EASE_IN_OUT, # direction
		off # delay
	)
	
	$fade.interpolate_property(
		self, # node
		"opacity", # property
		0, # start value
		1, # end value
		Settings.dict.fadedur, # duration
		Tween.TRANS_LINEAR, # easing type
		Tween.EASE_IN_OUT, # direction
		(Settings.dict.fadedur / 2) + off # delay
	)
	
	$tween.start()
#	$fade.start()

func _process(delta):
	opacity = ((-Settings.dict.interpdist) - (translation.z)) / (-Settings.dict.interpdist)

func _on_tween_tween_all_completed():
	Settings.dict.ctm += 1
	Settings.dict.cmb = 0
	
	if Settings.dict.nomiss:
		get_tree().quit()
	
	queue_free()
