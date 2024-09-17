extends Control

func _ready() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))
		
	

func on_button_pressed(button_name):
	match button_name:
		"main_menu":
			transition_screen.fade_in()
			transition_screen.scene_path = "res://Scenes/menu.tscn"
		"quit":
			transition_screen.can_quit = true
			transition_screen.fade_in()
