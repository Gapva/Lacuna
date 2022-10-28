extends WorldEnvironment

func _ready():
	if Settings.dict.bloom:
		self.environment.glow_bloom = 0.03
	else:
		self.environment.glow_bloom = 0
