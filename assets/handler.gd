extends Spatial

onready var world = load("user://worlds/" + Settings.dict.cworld + ".tres")
const note = preload("res://assets/note.tscn")

var mapf = File.new()
var map = ""

var iter = 0

var dframe = 0

# empty vars
var bpm = ""
var md = ""
var offset = ""
var total = ""
var sname = ""
var artist = ""
var mappers = []
var desc = ""
var ext = ""

func spawn(loc,i):
	
	var fnote = note.instance()
	fnote.off = loc["time"]
	fnote.translation.z = abs(Settings.dict.interpdist) * -1
	
	fnote.modulate = Settings.dict.cols[i % len(Settings.dict.cols)]
	
	print("t" + str(loc["time"]) + "s\n(" + str(loc["x"]) + "," + str(loc["y"]) + ")\nl(" + loc["lyric"] + ")\n")
	
	# handle columns
	fnote.translation.x = loc["x"]
	fnote.translation.y = loc["y"]
	
	fnote.lyric = loc["lyric"]
		
	self.add_child(fnote)
	
func smusic(ofst):
	if ofst >= 0:
		yield(get_tree().create_timer(ofst * 0.001),"timeout")
		$song.play()
	elif ofst < 0:
		$song.play()
		$song.seek(abs(ofst) * 0.001)

func _ready():
	
	var dir = Directory.new()
	dir.open("user://")
	dir.make_dir("worlds")
	dir.make_dir("maps")
	
	$world.environment = world
	
	mapf.open("user://maps/" + Settings.dict.cmap + "/main.lacuna.json",mapf.READ)
	map = JSON.parse(mapf.get_as_text()).result
	mapf.close()

	if not map["name"]:
		OS.alert("Please set up/add core/required files before running Lacuna","LacERRna")
		OS.shell_open(ProjectSettings.globalize_path("user://"))

	# setup
	sname = map["name"]
	artist = map["artist"]
	mappers = map["mappers"]
	desc = map["description"]
	ext = map["extension"]

	bpm = map["bpm"]
	offset = map["offset"]
	md = map["notes"]
	
	# tempo init
	$song.pitch_scale = Settings.dict.mapspeed * 0.01
	$bpm.wait_time = 15 / (float(bpm) * (Settings.dict.mapspeed * 0.01))
	print("BPM set to " + str(bpm))
	
	# offset init
	print("Map offset is now " + str(offset))
	
	# setup map data
	
	
	Settings.dict.ctotal = 0
	Settings.dict.ctm = 0
	Settings.dict.cmb = 0
	
	Engine.time_scale = Settings.dict.mapspeed * 0.01
	
	# load audio
#	var sfile = File.new()
#	sfile.open("user://maps/" + Settings.dict.cmap + "/main." + ext,File.READ)
#	$song.stream.set_data(sfile.get_buffer(sfile.get_len()))
#	$song.stream.set_loop(false)
	
	$song.stream = AudioStream.new()
	
	yield(get_tree().create_timer(Settings.dict.breaktime),"timeout")
	
	smusic(float(offset))
	
	# readymap
	for i in range(0,len(md)):
		spawn(md[i],i)

# map
func _on_bpm_timeout():
	pass
#	if iter <= len(md) - 1:
#		spawn(md[iter])
#	iter += 1
#	if iter > len(total):
#		$field.misses = str(len(total) - $field.hits)
	
func _process(delta):
	dframe += delta
#	if dframe >= 15.0 / float(bpm):
#		dframe -= 15.0 / float(bpm)
#		if iter <= len(md) - 1:
#			spawn(md[iter])
#			iter += 1
	if iter > len(total):
		$field.misses = str(len(total) - $field.hits)
	$hits.text = str($field.hits) + "/" + str(Settings.dict.ctotal) + " | " + str(Settings.dict.ctm) + " misses"
	if $field.hits > 0:
		var expr = Expression.new()
		var _result = expr.parse($hits.text.split(" ")[0])
		$combo.text = str(Settings.dict.cmb) + " combo"
