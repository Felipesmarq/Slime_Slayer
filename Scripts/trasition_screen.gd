extends CanvasLayer

var scene_path = ""
var can_quit = false

func fade_in(opt: bool = false):
	if opt:
		$AnimationPlayer.play("wave_cleared")
		return
	$AnimationPlayer.play("fade_in")



func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		
		if can_quit:
			get_tree().quit()
			return
			
		get_tree().change_scene_to_file(scene_path)
		$AnimationPlayer.play("fade_out")
		
	if anim_name == "wave_cleared":
		get_tree().change_scene_to_file(scene_path)
		$AnimationPlayer.play("fade_out")
