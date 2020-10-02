extends Node

onready var shape = $BallClick
onready var ball_hit = $BallHit
func _ready():
	$MusicLayer.start()

func _input(event):
	# fade in and out on accept
	if event.is_action_pressed("ui_accept"):
		if $MusicLayer.active:
			$MusicLayer.fade_out()
		else:
			$MusicLayer.fade_in()
