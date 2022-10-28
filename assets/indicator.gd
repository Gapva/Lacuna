extends Sprite3D

func _process(delta):
	global_translation = Vector3(0,0,$"..".global_translation.z)
	var rt = sqrt(($"..".translation.x * $"..".translation.x) + ($"..".translation.y * $"..".translation.y)) * 0.1
	scale = Vector3(rt,rt,1)
