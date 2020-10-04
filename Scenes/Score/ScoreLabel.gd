extends Label

# not great in terms of optimisation but whatever
func _process(_delta):
	set_text(str("Score: ", Score.score))
