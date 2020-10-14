extends Node2D

# timer variables

const TIMER_STARTING_INTERVAL   : float = 2.5   # how long between spawns at beginning
const TIMER_DECREASE_MULTIPLIER : float = 0.9
var   timer_tipping_point       : float = 1.0   # the current lowest spawn interval
var   timer_current_value       : float = TIMER_STARTING_INTERVAL   # the current value
# subtimer
var   subtimer_value            : float = 0

# shape vars
onready var shape_scene = load("res://Scenes/Shape/shape.tscn")

# screen
var SCREEN_HEIGHT : int = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH  : int = ProjectSettings.get_setting("display/window/size/width")

func _ready():
	self.spawn_shape()

func _process(delta):
	self.timer_tick(delta)
	self.subtimer_tick(delta)




# function that spawns a shape
func spawn_shape():
	var shape_instance = shape_scene.instance()
	add_child(shape_instance)
	# log
	print("SPAWNED SHAPE")



# timer stuff

func timer_tick(delta):
	if timer_current_value > timer_tipping_point:
		timer_current_value -= delta * .2
	else:
		print("TIPPED at: ", timer_current_value)
		self.timer_tip()

func timer_tip():
	# reset current timer value
	timer_current_value  = TIMER_STARTING_INTERVAL
	# increase how low the timer can go
	timer_tipping_point *= TIMER_DECREASE_MULTIPLIER


# subtimer keeps track when to spawn shapes
func subtimer_tick(delta):
	if subtimer_value < timer_current_value:
		subtimer_value += delta
	else:
		
		subtimer_value = 0
		self.spawn_shape()
