extends Node

const MAX_HEALTH = 5
var score  : int = 0
var health : int = MAX_HEALTH

func _ready():
	change_score(0)

# setting score
func change_score(s):
	score = s

func increment_score(amount : int = 1):
	change_score(score + amount)

# setting health
func decrement_health():
	if health > 1:
		health -= 1
		MusicManager.change_music_layer()
	else:
		print("You lose")
		var _scene_data = get_tree().change_scene("res://Scenes/Lost/Lost.tscn")
		

func reset():
	change_score(0)
	health = MAX_HEALTH
	MusicManager.reset_music_layers()


func _process(_delta):
	self.change_color()

# keep track of color as it tweens
var c : float = 0.9
func change_color():
	# target color based on health
	var t : float = float(health) / float(MAX_HEALTH)
	c += (t - c) * 0.01
	# change background color
	VisualServer.set_default_clear_color(Color(c, c*0.97, c*0.94))
