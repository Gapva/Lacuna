extends Label

func _process(delta):
	modulate.a += (0 - modulate.a) / Settings.dict.lfade
