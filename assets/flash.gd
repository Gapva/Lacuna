extends ColorRect

func _ready():
	color = Settings.dict.fcolor

func _process(delta):
	modulate.a += (0 - modulate.a) / Settings.dict.ffade
