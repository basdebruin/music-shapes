extends Label

func _ready():
	set_text(heart_string(Score.MAX_HEALTH))
	

# change string when health changes
var last_health_value : int = Score.MAX_HEALTH
func _process(_delta):
	if Score.health != last_health_value:
		set_text(heart_string(Score.health))
		last_health_value = Score.health


func heart_string(n : int = 0):
	# make a string with n hearts
	var s : String = ""
	for _i in range(n):
		s += "♥"
	return s
