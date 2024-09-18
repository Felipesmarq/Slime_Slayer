extends Control



func _ready() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))
		
	

func on_button_pressed(button_name):
	match button_name:
		"new_game":
			$button_sound.play()
			transition_screen.scene_path = "res://Scenes/Levels/level_1.tscn"
			transition_screen.fade_in()
		
		"controls":
			$button_sound.play()
			transition_screen.scene_path = "res://Scenes/controls.tscn"
			transition_screen.fade_in()
		"quit":
			$button_sound.play()
			transition_screen.can_quit = true
			transition_screen.fade_in()
