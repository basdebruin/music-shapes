extends Label

var score : int = 0

func _ready():
	self.change_score(0)

func change_score(s):
	score = s
	set_text(str("Score: ", score))

func increment_score():
	self.change_score(score + 1)
