extends Node

onready var shape = $BallClick
onready var ball_hit = $BallHit

onready var chorus = AudioServer.get_bus_effect(AudioServer.get_bus_index("Music"), 0)

onready var tween = $Tween

var tween_active = false

func _ready():
	$Drone1.start()
	
	
func _input(event):
	# fade in and out on accept
	if event.is_action_pressed("ui_accept"):
		if $Drone1.active:
			$Drone1.fade_out()
		else:
			$Drone1.fade_in()


func _process(delta):
	_change_chorus()
	
	print("drone 2 playing: ", $Drone2.is_playing())
	


func _change_chorus():
	if Score.score > 1 and tween_active == false:
		tween_active = true
		#how many points needs to be changed
		
		#!!! drone 2 doesn't start
		$Drone2.start()
		
		#tween chorus to max
		tween.interpolate_property(
		chorus,        # context
		"dry",   # property
		1,          # from current value
		0,           # to
		2.0, # duration
		1,     # transition type
		tween.EASE_IN, # ease type
		0              # delay
	)
	
	tween.interpolate_property(
		chorus,        # context
		"wet",   # property
		0,          # from current value
		1,           # to
		2.0, # duration
		1,     # transition type
		tween.EASE_IN, # ease type
		0              # delay
	)
	tween.start()
