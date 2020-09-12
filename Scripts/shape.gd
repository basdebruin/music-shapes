extends KinematicBody2D

# CONSTANTS
const VEL_MIN : int = 500
const VEL_MAX : int = 600

const GRAVITY : float = 300.0

# screen
var SCREEN_HEIGHT : int = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH  : int = ProjectSettings.get_setting("display/window/size/width")


# list possible shapes
enum SHAPES {
	BOX     = 0,
	CIRCLE  = 1,
	POLY    = 2
}

# VARIABLES
var shape = SHAPES.CIRCLE
var timeSinceSpawn : float = 0.0  # to prevent instant removal

# calc rand begining vel
var vel : Vector2 = Vector2(0, 0)

func _ready():
	# set initial velocity
	var vel_x : float =  rand_range(-VEL_MIN*.1, VEL_MIN*.1)
	var vel_y : float = -rand_range(VEL_MIN,  VEL_MAX)
	vel = Vector2(vel_x, vel_y)

# movement process
func _physics_process(delta):
	# move
	vel = move_and_slide(vel, Vector2.UP)
	# add gravity
	vel.y += GRAVITY * delta
	
	# check if above 0
	if timeSinceSpawn > 1.0 and position.y > SCREEN_HEIGHT:
		self.went_offscreen()
	else:
		timeSinceSpawn += delta

func went_offscreen():
	print("OFF SCREEN")
	get_parent().remove_child(self)
