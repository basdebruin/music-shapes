extends Node2D


# shape spawn timer variables
const SPAWN_INTERVAL   : float = 4.0   # seconds
var timeSinceLastSpawn : float = 0.0

# shape vars
onready var shape_scene = load("res://Scenes/shape.tscn")

# screen
var SCREEN_HEIGHT : int = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH  : int = ProjectSettings.get_setting("display/window/size/width")

func _ready():
	self.spawn_shape()

func _process(delta):
	# check shape timer
	if timeSinceLastSpawn > SPAWN_INTERVAL:
		self.spawn_shape()
		timeSinceLastSpawn = 0
	else:
		timeSinceLastSpawn += delta
		

# function that spawn a shape
func spawn_shape():
	var shape_instance = shape_scene.instance()
	add_child(shape_instance)
	# position
	shape_instance.set_position(Vector2(
		rand_range(50, SCREEN_WIDTH - 50), 
		SCREEN_HEIGHT + 50))
	# log
	print("SPAWNED SHAPE")
