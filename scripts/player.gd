extends CharacterBody2D


const SPEED = 300.0
var anim_dir = "idle"


func _physics_process(_delta):
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
	var anim = $AnimatedSprite2D
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
	anim_dir = movement
