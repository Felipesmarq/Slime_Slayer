extends CharacterBody2D

var speed = 100
var health = 100

var player_alive = true
var enemy_in_range = false

var player_state

var bow_equiped = false
var bow_cooldown = true
var arrow = preload("res://Scenes/arrow.tscn")
var mouse_location_player = null
var is_shooting = false

func _physics_process(delta: float) -> void:
	
	enemy_attack()
	mouse_location_player = get_global_mouse_position() - self.position
	
	if health <= 0:
		player_alive = false
		health = 0
		print("player has been killed")
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(1).timeout
		transition_screen.fade_in()
		transition_screen.scene_path = "res://Scenes/game_over.tscn"
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not is_shooting:
		if direction.x == 0 and direction.y == 0:
			player_state = "idle"
		elif direction.x != 0 or direction.y != 0:
			player_state = "running"
	
		velocity = direction * speed
		move_and_slide()
	
	if Input.is_action_just_pressed("e"):
		if bow_equiped:
			bow_equiped = false
		else:
			bow_equiped = true
			
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_attack") and bow_equiped and bow_cooldown:
		is_shooting = true
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.5).timeout
		bow_cooldown = true
		is_shooting = false
	
	if Input.is_action_just_pressed("space"):
		dash()
	
	play_anim(direction)
	

func play_anim(dir):
	if !bow_equiped:
		if player_state == "idle":
			$AnimatedSprite2D.play("idle")
		elif player_state == "running":
			if dir.y == -1:
				$AnimatedSprite2D.play("n-run")
			elif dir.x == -1:
				$AnimatedSprite2D.play("w-run")
			elif dir.y == 1:
				$AnimatedSprite2D.play("s-run")
			elif dir.x == 1:
				$AnimatedSprite2D.play("e-run")
			
			elif dir.x > 0.5 and dir.y < -0.5:
				$AnimatedSprite2D.play("ne-run")
			elif dir.x > 0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("se-run")
			elif dir.x < -0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("sw-run")
			elif dir.x < -0.5 and dir.y < -0.5:
				$AnimatedSprite2D.play("nw-run")
	else:
		if player_state == "idle":
			$AnimatedSprite2D.play("idle")
		elif player_state == "running":
			if dir.y == -1:
				$AnimatedSprite2D.play("n-run")
			elif dir.x == -1:
				$AnimatedSprite2D.play("w-run")
			elif dir.y == 1:
				$AnimatedSprite2D.play("s-run")
			elif dir.x == 1:
				$AnimatedSprite2D.play("e-run")
			
			elif dir.x > 0.5 and dir.y < -0.5:
				$AnimatedSprite2D.play("ne-run")
			elif dir.x > 0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("se-run")
			elif dir.x < -0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("sw-run")
			elif dir.x < -0.5 and dir.y < -0.5:
				$AnimatedSprite2D.play("nw-run")
		
		
		if is_shooting:
			if mouse_location_player.x >= -25 and mouse_location_player.x <= 25 and mouse_location_player.y < 0:
				$AnimatedSprite2D.play("n-attack")
			elif mouse_location_player.y >= -25 and mouse_location_player.y <= 25 and mouse_location_player.x > 0:
				$AnimatedSprite2D.play("e-attack")
			elif mouse_location_player.x >= -25 and mouse_location_player.x <= 25 and mouse_location_player.y > 0:
				$AnimatedSprite2D.play("s-attack")
			elif mouse_location_player.y >= -25 and mouse_location_player.y <= 25 and mouse_location_player.x < 0:
				$AnimatedSprite2D.play("w-attack")
			
			elif mouse_location_player.x >= 25 and mouse_location_player.y <= -25:
				$AnimatedSprite2D.play("ne-attack")
			elif mouse_location_player.x >= 0.5 and mouse_location_player.y >= 25:
				$AnimatedSprite2D.play("se-attack")
			elif mouse_location_player.x <= -0.5 and mouse_location_player.y >= 25:
				$AnimatedSprite2D.play("sw-attack")
			elif mouse_location_player.x <= -25 and mouse_location_player.y <= -25:
				$AnimatedSprite2D.play("nw-attack")


func player():
	pass


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_range = false

func enemy_attack():
	if enemy_in_range:
		health -= 100
		
		print("player dead")
		

func dash():
	speed = speed * 3
	$dash.start()

func _on_timer_timeout() -> void:
	speed = 100
	
