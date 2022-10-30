extends Sprite3D

var nparticles = preload("res://assets/nparticles.tscn")

var mvx = 0
var mvy = 0

var fx = 0
var fy = 0

var tab = true

var pmax = 10.2
var nmax = -10.2

var hits = 0
var misses = "Calculating..."

func _notification(nt):
	if nt == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		tab = true
	elif nt == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		tab = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	OS.window_fullscreen = Settings.dict.full
	$cursor/particles.visible = Settings.dict.cursortrail
	$cursor/flashlight.visible = Settings.dict.flashlight

func _input(event):
	if event is InputEventMouseMotion:
		$cursor.translation.x += (event.relative.x * 0.09) *  Settings.dict.sens
		$cursor.translation.y -= (event.relative.y * 0.09) *  Settings.dict.sens
		$"../connect".points = [Vector3(0,0,0),-$cursor.global_translation]
	if event.is_action_pressed("ui_cancel"):
		OS.shell_open(ProjectSettings.globalize_path("user://setup.json"))
		get_tree().quit()
	if event.is_action_pressed("ui_accept"):
		get_tree().paused = not get_tree().paused
	if event.is_action_pressed("recenter"):
		$cursor.translation.x = 0
		$cursor.translation.y = 0
	if event.is_action_pressed("fullsc"):
		OS.window_fullscreen = not OS.window_fullscreen

func _process(delta):
#	mvx = get_viewport().get_mouse_position().x / (get_viewport().get_visible_rect().size.x / 2)
#	mvy = get_viewport().get_mouse_position().y / (get_viewport().get_visible_rect().size.y / 2)
#	if tab:
#		get_viewport().warp_mouse(Vector2((get_viewport().get_visible_rect().size.x / 2),(get_viewport().get_visible_rect().size.y / 2)))
#	fx += (mvx - 1) * Settings.dict.sens
#	fy -= (mvy - 1) * Settings.dict.sens
#	$cursor.translation.x = (fx - $cursor.translation.x) * Settings.lerpdur
#	$cursor.translation.y = (fy - $cursor.translation.y) * Settings.lerpdur
	
#	if $cursor.translation.x > pmax:
#		$cursor.translation.x = pmax
#	if $cursor.translation.y > pmax:
#		$cursor.translation.y = pmax
#
#	if $cursor.translation.x < nmax:
#		$cursor.translation.x = nmax
#	if $cursor.translation.y < nmax:
#		$cursor.translation.y = nmax
		
	get_parent().get_node("camera").translation.x = lerp(get_parent().get_node("camera").translation.x,$cursor.translation.x * 0.25,(1 / Settings.dict.lockfactor))
	get_parent().get_node("camera").translation.y = lerp(get_parent().get_node("camera").translation.y,$cursor.translation.y * 0.25,(1 / Settings.dict.lockfactor))
	
	$cursor.rotation_degrees.z -= Settings.dict.spin * delta

func _on_area_area_entered(area):
	area.get_parent().queue_free()

func _on_ccol_area_entered(area):
	if area.name == "ncol":
		
		if Settings.dict.noteparticles:
			var cnparticles = nparticles.instance()
			self.add_child(cnparticles)
#			cnparticles.visible = Settings.dict.noteparticles
			cnparticles.global_translation = area.global_translation
			cnparticles.get_node("particles").emitting = true
		
		hits += 1
		Settings.dict.cmb += 1
		area.get_parent().queue_free()
		
		# lyric
		if not area.get_parent().lyric == "":
			$"../lyrics".text = area.get_parent().lyric
			$"../lyrics".modulate.a = Settings.dict.lopac
		if area.get_parent().flash:
			$"../flash".modulate.a = Settings.dict.fopac
