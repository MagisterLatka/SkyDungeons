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
var isDeathTimer = false

var isInvulnerable = false
var timeInvis = 0
var isRed = false

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
	
func _process(delta):
	timeInvis += delta
	if isInvulnerable and (timeInvis >= 0.125) and not isRed:
		$AnimatedSprite2D.modulate = Color(1, 0, 0)
		isRed = true
		timeInvis = 0
	elif isInvulnerable and (timeInvis >= 0.125) and isRed:
		$AnimatedSprite2D.modulate = Color(1, 1, 1)
		isRed = false
		timeInvis = 0
	
func take_damage(damage):
	if not isInvulnerable:
		Game.health = Game.health - damage
		$HitSound.play()
		if Game.health <= 0:
			Game.health = 0
			$GameOverSound.play()
			isDead = true
			return 0
		$AnimatedSprite2D.modulate = Color(1, 0, 0)
		isRed = true
		timeInvis = 0
		$VulnerabilityTimer.start()
		isInvulnerable = true

		
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
		if !isDeathTimer:
			get_node("DeathTimer").start()
			isDeathTimer = true
	else:
		Sprite.play("death")


func _on_sword_hit_area_entered(area):

	if area.is_in_group("mobs"):
		
		area.take_damage(1)
	
	
func _on_sword_hit_down_area_entered(area):
	if area.is_in_group("mobs"):

		area.take_damage(1)


func _on_sword_hit_up_area_entered(area):
	if area.is_in_group("mobs"):

		area.take_damage(1)


func _on_sword_hit_left_area_entered(area):
	if area.is_in_group("mobs"):

		area.take_damage(1)


func _on_vulnerability_timer_timeout():
	isInvulnerable = false


func _on_death_timer_timeout():
	Game.game_over()
