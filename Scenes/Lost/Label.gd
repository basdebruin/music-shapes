extends Label

var responses = [
	"You can always start over",
	"It's cool, no biggie",
	"You did really well this time",
	"Next time you'll do even better!",
	"Going strong, keep going!",
	"There's always next time",
	"Get back at it!"
]

func _ready():
	set_text(choose(responses) + "\n\n Click to try again →")
	
	
func choose(array):
	return array[randi() % len(array)]
