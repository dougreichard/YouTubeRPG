extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null
var health = 100
var player_in_attack_zone = false
var can_take_damage = true
var played_dead = false

func _physics_process(delta):
	if health<=0:
		if not played_dead:
			played_dead = true
			$AnimatedSprite2D.play("death")
		return
		
	deal_with_damage()
	if player_chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.flip_h = player.position.x < position.x
		
	


func _on_detection_body_entered(body):
	if health>0:
		player = body
		player_chase = true
		$AnimatedSprite2D.play("move_side")
	


func _on_detection_body_exited(body):
	
	player = null
	player_chase = false
	if health>0:
		$AnimatedSprite2D.play("move_idle")
	
func enemy():
	pass


func _on_enemy_hit_box_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true


func _on_enemy_hit_box_body_exited(body):
	player_in_attack_zone = false

func deal_with_damage():
	if can_take_damage and player_in_attack_zone and Global.player_current_attack and health > 0:
		health -= 20
		print("health {0}".format([health]))
		can_take_damage = false
		$take_damage_cooldown.start()
		
		


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	$take_damage_cooldown.stop()
