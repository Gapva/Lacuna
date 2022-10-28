extends Node

# onready var path = OS.get_executable_path().get_base_dir()
# onready var spath = ProjectSettings.globalize_path("res://")
# onready var dir = Directory.new()
# onready var dpath = dir.change_dir(path)
onready var content
onready var config

onready var dict = {}

func _ready():
	# initialization
	var file = File.new()
	file.open("user://setup.json",File.READ)
	content = file.get_as_text()
	file.close()
	config = JSON.parse(content).result

	# core settings
	dict.cmap = config["currentMap"] # map to be played
	dict.cworld = config["currentWorld"] # background world to be displayed in-map

	# personalization
	dict.sens = config["sensitivity"] # sensitivity; multiplier (not a decimal between 0 and 1); can be negative
	dict.lockmode = 1 # 0 for full lock, 1 for half
	dict.lockfactor = config["followFactor"] # multiplier for how intense halflock is
	dict.breaktime = config["breakTime"] # time to wait before starting the map
	dict.interpdist = config["interpolationDistance"] # note spawn distance (also affects approach rate, may cause slight delay)
	dict.fadedur = config["noteFade"] # how long notes will take (in seconds) before appearing
	dict.lfade = config["lyricFadeDiv"] # how long lyrics will take (interpolation divisor) to disappear
	dict.lopac = config["lyricOpacity"] # how opaque lyrics are
	dict.spin = config["cursorSpin"] # how much the cursor spins (in units * delta) every _process call

	# modifications
	dict.mapspeed = config["mapSpeed"] # speed of the map, 100 = 100%
	dict.flashlight = config["flashlight"] # "don't use with dementia" -frostlines
	dict.ghost = config["ghost"] # notes fade out as they approach the cursor
	dict.nomiss = config["noMiss"] # exit the game if you miss

	# graphics & performance
	dict.noteparticles = config["noteParticles"] # show note particles (doesn't work properly yet)
	dict.cursortrail = config["cursorTrail"] # show cursor trail (also doesn't work properly yet)
	dict.full = config["fullscreen"]

	# note colors
	dict.cols = config["noteColors"]

	# probably dont change these because they could break
	dict.ctotal = 0 # total notes in the whole map (fully calculated from beginning)
	dict.ctm = 0 # total notes spawned in the map (calculated as map is played)
	dict.cmb = 0 # current combo; resets to zero when a note is missed
