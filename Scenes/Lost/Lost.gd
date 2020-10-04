extends Node2D

# Input Event
func _input(event):
	if event is InputEventMouseButton          \
		and event.button_index == BUTTON_LEFT  \
		and event.pressed:
			Score.reset()
			get_tree().change_scene("res://Scenes/main_screen.tscn")
