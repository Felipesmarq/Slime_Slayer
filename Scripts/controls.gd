extends Control


func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(on_button_pressed.bind(button.name))
		
		
func on_button_pressed(button_name):
	match button_name:
		"back":
			$button_sound.play()
			transition_screen.scene_path = "res://Scenes/menu.tscn"
			transition_screen.fade_in()
