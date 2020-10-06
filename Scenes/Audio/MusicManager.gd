extends Node

onready var shape = $BallClick
onready var ball_hit = $BallHit

onready var chorus = AudioServer.get_bus_effect(AudioServer.get_bus_index("Music"), 0)

func _ready():
#	$Drone1.start()
	pass

func _input(event):
	# fade in and out on accept
	if event.is_action_pressed("ui_accept"):
		if $Drone1.active:
			$Drone1.fade_out()
		else:
			$Drone1.fade_in()


func _process(delta):
	if Score.score > 1:
		$Drone2.start()
		
		#needs tween!!
#		chorus.dry = 0
#		chorus.wet = 1
	
	print("drone 2 playing: ", $Drone2.is_playing())
	
