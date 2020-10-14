extends Node

onready var shape = $BallClick
onready var shape_hit = $BallHit

onready var chorus = AudioServer.get_bus_effect(AudioServer.get_bus_index("Music"), 0)

onready var chorus_tween = $ChorusTween

onready var game_over_sound = $GameOver

onready var score_chords = $ScoreIncrease

var current_music_layer = 0

func _ready():
	# ready music layers
	$Drone1.start()
	# false so it's not audible at start
	$Drone2.start(false)
	
	
# DEBUG
#func _input(event):
#	# fade in and out on accept
#	if event.is_action_pressed("ui_accept"):

# increase intensity
func change_music_layer():
	if Score.health <= 3:
		if Score.health > 1 and current_music_layer != 1:
			current_music_layer = 1
			$Drone2.fade_in()
			$Drone1.fade_out()
		elif Score.health <= 1 and current_music_layer != 2:
			current_music_layer = 2
			self.start_chorus()


func reset_music_layers():
	current_music_layer = 0
	$Drone1.fade_in()
	$Drone2.fade_out()
	self.stop_chorus()


func start_chorus():
	#tween chorus to max
	chorus_tween.interpolate_property(
		chorus,        # context
		"dry",         # property
		1,             # from current value
		0,             # to
		2.0,           # duration
		1,             # transition type
		chorus_tween.EASE_IN, # ease type
		0              # delay
	)
	
	chorus_tween.interpolate_property(
		chorus,        # context
		"wet",         # property
		0,             # from current value
		1,             # to
		2.0,           # duration
		1,             # transition type
		chorus_tween.EASE_IN, # ease type
		0              # delay
	)
	chorus_tween.start()


func stop_chorus():
	#tween chorus to min
	chorus_tween.interpolate_property(
		chorus,        # context
		"dry",         # property
		0,             # from current value
		1,             # to
		2.0,           # duration
		1,             # transition type
		chorus_tween.EASE_IN, # ease type
		0              # delay
	)
	
	chorus_tween.interpolate_property(
		chorus,        # context
		"wet",         # property
		1,             # from current value
		0,             # to
		2.0,           # duration
		1,             # transition type
		chorus_tween.EASE_IN, # ease type
		0              # delay
	)
	chorus_tween.start()
	
func _play_chord(child):
	#get the children
	#play the chord
	score_chords.get_child(child).play()
	
