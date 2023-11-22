extends CharacterBody2D


const SPEED = 200.0
signal hit

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var Sprite = $AnimatedSprite2D
@onready var anim = $AnimationPlayer
var lastDirection = 1 #1 - w prawo, 2 - w dol, 3 - w lewo, 4 - w gore
var screen_size
var isAttack = false
var isDead = false

func _ready():
	screen_size = get_viewport_rect().size
	$SwordHit_Right/CollisionShape2D.disabled = true
	$SwordHit_Left/CollisionShape2D.disabled = true
	$SwordHit_Down/CollisionShape2D.disabled = true
	$SwordHit_Up/CollisionShape2D.disabled = true
	
func _physics_process(delta):

	if !isAttack && !isDead:
		
		var directionX = Input.get_axis("MoveLeft", "MoveRight")
		var directionY = Input.get_axis("MoveUp", "MoveDown")
		
		var velocity = Vector2.ZERO
		if Input.is_action_pressed("MoveRight"):
			velocity.x += 1
		if Input.is_action_pressed("MoveLeft"):
			velocity.x -= 1
		if Input.is_action_pressed("MoveDown"):
			velocity.y += 1
		if Input.is_action_pressed("MoveUp"):
			velocity.y -= 1
		if Input.is_action_pressed("Attack"):
			isAttack = true
		
		if velocity.length() > 0:
			velocity = velocity.normalized() * SPEED
			#Sprite.animation = "run"
			if directionY != 0:
				if directionY > 0:
					Sprite.play("run_down")	
					lastDirection = 2				
				else:
					Sprite.play("run_up")
					lastDirection = 4
			else:
				Sprite.play("run")
				if directionX < 0:
					Sprite.flip_h = true	
					lastDirection = 3				
				else:
					Sprite.flip_h = false
					lastDirection = 1

		else:
			if lastDirection == 2:
				Sprite.play("idle_down")
			elif lastDirection == 4:
				Sprite.play("idle_up")
			else:
				Sprite.play("default")
			
		position += velocity * delta

			
	elif isAttack:
		Attack()
	else:
		death_player()
		
	move_and_slide()
	
func take_damage(damage):
	Game.health = Game.health - damage
	if Game.health <= 0:
		Game.health = 0
		isDead = true

		
func Attack():
	if lastDirection == 2:
		anim.play("attack_down")
	elif lastDirection == 4:
		anim.play("attack_up"	)
	elif lastDirection == 3:
		anim.play("attack_left")
	else:
		anim.play("attack_right")
		
	if Sprite.frame == 6:
		isAttack = false	

func _on_enemies_detection_body_entered(body):
	pass

func death_player():
	
	if Sprite.frame == 8:
		Sprite.frame = 8
	else:
		Sprite.play("death")


func _on_sword_hit_area_entered(area):

	if area.is_in_group("mobs"):
		print("tu")
		area.take_damage(1)
	
	
func _on_sword_hit_down_area_entered(area):
	if area.is_in_group("mobs"):
		print("tu")
		area.take_damage(1)


func _on_sword_hit_up_area_entered(area):
	if area.is_in_group("mobs"):
		print("tu")
		area.take_damage(1)


func _on_sword_hit_left_area_entered(area):
	if area.is_in_group("mobs"):
		print("tu")
		area.take_damage(1)
