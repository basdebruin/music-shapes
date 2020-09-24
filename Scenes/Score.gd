extends Node

var score : int = 0

func _ready():
	change_score(0)

func change_score(s):
	score = s
	

func increment_score():
	change_score(score + 1)
	print("score is now: ", str(score))
