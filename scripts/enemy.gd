extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed

		$AnimatedSprite2D.flip_h = player.position.x < position.x
		
	


func _on_detection_body_entered(body):
	player = body
	player_chase = true
	$AnimatedSprite2D.play("move_side")
	


func _on_detection_body_exited(body):
	player = null
	player_chase = false
	$AnimatedSprite2D.play("move_idle")
	
