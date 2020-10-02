extends AudioStreamPlayer

# constants
const FADE_DURATION : float = 2.0 # in seconds
const TRANS_TYPE    : int   = 1   # SINE TWEEN
const MAX_VOLUME    : float = 0.0 # in dbs, silent is -80 db

var active : bool = true

onready var tween = $Tween;

func start(layer_is_on : bool = true):
	# set volume based on layer_is_on
	if layer_is_on:
		set_volume_db(MAX_VOLUME)
	else:
		set_volume_db(-80)
		active = false
	# play self
	play()


# MusicLayer fades in and out but doesn't stop playing in the background

func fade_out():
	# tween music volume down to 0
	tween.interpolate_property(
		self,        # context
		"volume_db",   # property
		null,          # from current value
		-80,           # to
		FADE_DURATION, # duration
		TRANS_TYPE,     # transition type
		Tween.EASE_IN, # ease type
		0              # delay
	)
	tween.start()
	active = false
	print("fade out")


func fade_in():
	# tween music volume up to MAX_VOLUME
	tween.interpolate_property(
		self, 
		"volume_db", 
		null, 
		MAX_VOLUME, 
		FADE_DURATION, 
		TRANS_TYPE, 
		Tween.EASE_IN, 
		0
	)
	tween.start()
	active = true
	print("fade_in")
