extends CharacterBody2D


const SPEED = 300.0
var anim_dir = "front"

var enemy_in_range = false
var enemy_attack_cooldown = true
var health = 100
var alive = true
var player_died = false
var attack_in = false

func _physics_process(_delta):
	player_movement(_delta)
	enemy_attack()
	play_attack_animation()
	
	
	if health <= 0 and alive:
		alive = false
		$player_anim.play("die")
	

func player_movement(_delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		velocity.y = 0	
		play_animation("left")
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		velocity.y = 0
		play_animation("right")
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		velocity.x = 0
		play_animation("up")
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
		velocity.x = 0
		play_animation("down")
	else:
		velocity.x = 0
		velocity.y = 0	
		play_animation("idle")
	
	move_and_slide()

func play_animation(movement):
	var anim = $player_anim
	if attack_in:
		return
	if movement == anim_dir:
		return
	if movement == "right":
		anim.flip_h = false
		anim.play("move_side")
	elif movement == "left":
		anim.flip_h = true
		anim.play("move_side")
	elif movement == "up":
		anim.flip_h = false
		anim.play("move_back")	
	elif movement == "down":
		anim.flip_h = false
		anim.play("move_front")	
	elif anim_dir=="right" or anim_dir=="left":
		anim.flip_h = anim_dir=="left"
		anim.play("idle_side")	
	elif anim_dir=="up":
		anim.flip_h = false
		anim.play("idle_back")	
	else:
		anim.play("idle_front")	
	if movement != "idle":
		anim_dir = movement	
	
	
func play_attack_animation():
	var anim = $player_anim
		
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_in = true
		$deal_attack.start()
		#print("Swing "+anim_dir)
		if anim_dir == "right":
			anim.flip_h = false
			anim.play("attack_side")
		elif anim_dir == "left":
			anim.flip_h = true
			anim.play("attack_side")
		elif anim_dir == "up":
			anim.flip_h = false
			anim.play("attack_back")	
		elif anim_dir == "down":
			anim.flip_h = false
			anim.play("attack_front")	
		


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		if body.health >0:
			enemy_in_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range =false

func player():
	pass

func enemy_attack():
	if enemy_in_range and enemy_attack_cooldown:
		health -= 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("health {0}".format([health]) )
		

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


func _on_deal_attack_timeout():
	$deal_attack.stop()
	Global.player_current_attack = false
	attack_in = false
