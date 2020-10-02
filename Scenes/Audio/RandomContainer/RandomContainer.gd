extends Node

#Random Sound Container
#add audiostreamplayers as children to this container

func play_random_sound():
	randomize()
	var children = get_children()
	children[randi() % children.size()].play()
