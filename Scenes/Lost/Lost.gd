extends Node2D

func _ready():
	Score.reset()

# Input Event
func _input(event):
	if event is InputEventMouseButton          \
		and event.button_index == BUTTON_LEFT  \
		and event.pressed:
			Score.reset()
			var _scene_data = get_tree().change_scene("res://Scenes/main_screen.tscn")
