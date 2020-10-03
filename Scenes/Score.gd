extends Node

var score : int = 0

func _ready():
	change_score(0)

func change_score(s):
	score = s
	

func increment_score(amount : int = 1):
	change_score(score + amount)
	print("score is now: ", str(score))
