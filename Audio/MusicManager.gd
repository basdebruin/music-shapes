extends Node

onready var shape = $BallClick
onready var ball_hit = $BallHit
func _ready():
	$Drone.play()
