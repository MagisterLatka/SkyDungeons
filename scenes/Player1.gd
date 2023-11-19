extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const MAXHEALTH = 10
var health = MAXHEALTH
signal hit

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var Sprite = $AnimatedSprite2D
var lastDirection = 1 #1 - w prawo, 2 - w dol, 3 - w lewo, 4 - w gore
var screen_size
var isAttack = false
var isDead = false

func _ready():
	screen_size = get_viewport_rect().size

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
	#	Sprite.play("attack")
	#	if Sprite.frame == 6:
		#	#print("tu")
		#	isAttack = false
	else:
		death_player()
		
	move_and_slide()
	
func take_damage(damage):
	health = health - damage
	
func get_health():
	return health
		
func Attack():
	if lastDirection == 2:
		Sprite.play("attack_down")
	elif lastDirection == 4:
		Sprite.play("attack_up"	)
	else:
		Sprite.play("attack_left_right")
		
	if Sprite.frame == 6:
		isAttack = false
		take_damage(1)
	#await  Sprite.animation_finished
	

func _on_enemies_detection_body_entered(body):
	if body.name == "Player":
		print("Player xx")
		
func death_player():
	isDead = true
	#Sprite.play("death")


