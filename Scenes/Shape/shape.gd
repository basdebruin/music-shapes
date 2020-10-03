extends KinematicBody2D

# CONSTANTS
const VEL_MIN : int   = 500
const VEL_MAX : int   = 600
const X_MULT  : float = .2  # x variation multiplier

const GRAVITY : float = 300.0

var activated = false

# screen
var SCREEN_HEIGHT : int = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH  : int = ProjectSettings.get_setting("display/window/size/width")


# list possible shapes
enum SHAPES {
	BOX     = 0,
	CIRCLE  = 1,
	POLY    = 2
}
# preloaded images
const IMAGES = [
	preload("res://Assets/Shapes/box_green.png"),
	preload("res://Assets/Shapes/circle_red.png"),
	preload("res://Assets/Shapes/polygon_blue.png")
]


# VARIABLES
var shape = SHAPES.CIRCLE
var timeSinceSpawn : float = 0.0  # to prevent instant removal

var vel : Vector2 = Vector2(0, 0)

var vel_rotation : float = 0



func _ready():
	# set initial velocity
	var vel_x : float =  rand_range(-VEL_MIN*X_MULT, VEL_MIN*X_MULT)
	var vel_y : float = -rand_range(VEL_MIN,  VEL_MAX)
	vel = Vector2(vel_x, vel_y)
	
	# set random position 
	# with margin of 100
	set_position(Vector2(
		rand_range(100, SCREEN_WIDTH - 100), 
		SCREEN_HEIGHT + 100))
		
	# set random rotation
	# and rotational movement
	rotation = rand_range(0, 360)
	vel_rotation = vel_x * 0.005  # give random swing of rotation based on x movement
	
	# set image texture
	shape = randi() % len(SHAPES)   # random index
	$Sprite.set_texture(IMAGES[shape])
	
	# init AudioPlayer
	init_sound()



# movement process
func _physics_process(delta):
	# move
	vel = move_and_slide(vel, Vector2.UP)
	# add gravity
	vel.y += GRAVITY * delta
	# a little rotation
	rotation += vel_rotation
	vel_rotation *= .98
	
	# check collision
	if get_slide_count() > 0:
		self.on_collision()
	
	# check if above 0
	if timeSinceSpawn > 1.0 and position.y > SCREEN_HEIGHT + 50:
		self.destroy()
	else:
		timeSinceSpawn += delta
	

# Input Event
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton          \
		and event.button_index == BUTTON_LEFT  \
		and event.pressed:
			self.on_click(event)
		




# custom functions

func on_click(_event):
	# play sound
	MusicManager.shape.play_random_sound()
	
	# set active
	activate()
	
	# add a little extra movement
	vel.x *= 10
	vel.y -= 100


func destroy():
	get_parent().remove_child(self)


func on_collision():
	# play sound, check if playing to prevent glitch
	# not a perfect solution
	if not $AudioPlayer.playing:
		self.play_sound()
	
	#set active
	self.activate()


# SOUND
func init_sound():
	# load audio files based on shape
	if   shape == SHAPES.BOX:
		$AudioPlayer.stream = load("res://Sounds/Temp/OneShot1.wav")
	elif shape == SHAPES.CIRCLE:
		$AudioPlayer.stream = load("res://Sounds/Temp/OneShot2.wav")
	elif shape == SHAPES.POLY:
		$AudioPlayer.stream = load("res://Sounds/Temp/OneShot3.wav")


func play_sound():
	$AudioPlayer.play()
	
	

func activate(has_collided : bool = false):
	if not activated:
		activated = true
		# change color
		$Sprite.modulate = Color(.5, .5, .5)
		# add to Score
		Score.increment_score()
