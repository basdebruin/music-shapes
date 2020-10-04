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
	print("score is now: ", str(score))

# setting health
func decrement_health():
	if health > 1:
		health -= 1
	else:
		print("You lose")
		get_tree().change_scene("res://Scenes/Lost/Lost.tscn")
		

func reset():
	change_score(0)
	health = MAX_HEALTH
