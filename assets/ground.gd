extends MeshInstance

var under = false

func _physics_process(delta):
	if get_parent().get_node("field/cursor").translation.y < -38.566:
		under = true
	else:
		under = false
	
	if under:
		self.translation.y = lerp(self.translation.y,-20,0.025)
	else:
		self.translation.y = lerp(self.translation.y,-10,0.025)
