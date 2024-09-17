extends Node2D

var kill_count = 0

@onready var interface: CanvasLayer = get_node("interface")
@onready var label: Label = interface.get_node("enemies_left")

@export var target_kill_count: int
@export var next_level_scene_path: String
@export var current_level_scene_path: String

func _ready() -> void:
	transition_screen.scene_path = current_level_scene_path

func _process(delta):
	update_label()

func increase_kill_count():
	kill_count += 1
	if kill_count == target_kill_count:
		transition_screen.scene_path = next_level_scene_path
		transition_screen.fade_in(true)

func update_label():
	var inimigos_na_cena = get_tree().get_nodes_in_group("enemy")
	var quantidade_inimigos = inimigos_na_cena.size()
	
	label.text = "Enemies left:" + str(quantidade_inimigos)
