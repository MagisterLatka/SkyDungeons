extends CharacterBody2D

const speed = 200.0

func _physics_process(_delta):
	velocity = Vector2(0.0, 0.0)
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -speed
	elif (Input.is_action_pressed("ui_right")):
		velocity.x = speed
	if (Input.is_action_pressed("ui_up")):
		velocity.y = -speed
	elif (Input.is_action_pressed("ui_down")):
		velocity.y = speed
	
	move_and_slide()
