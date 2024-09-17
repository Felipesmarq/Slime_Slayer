extends CharacterBody2D

var speed = 85
var health = 100

var dead = false
var player_in_area = false
var player

func _ready():
	dead = false
	
func _physics_process(delta: float) -> void:
	update_health()
	if !dead:
		$detection_area/CollisionShape2D.disabled = false
		if player_in_area:
			
			var direction = (player.position - position).normalized()
			
			position += direction * speed * delta
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")  
	else:
		$detection_area/CollisionShape2D.disabled = true
		
	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body
		

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area =  false


func _on_hitbox_area_entered(area: Area2D) -> void:
	var damage
	if area.has_method("arrow_deal_damage"):
		damage = 50
		take_damage(damage)
	if area.has_method("player"):
		damage = 100
		area.take_damage(damage)

func take_damage(damage):
	health = health - damage
	if health <= 0 and !dead:
		death()
		
		
func death():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	get_tree().call_group("level", "increase_kill_count")
	queue_free()

func enemy():
	pass

func update_health():
	var health_bar = $health_bar
	health_bar.value = health
	
