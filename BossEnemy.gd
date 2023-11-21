extends Area2D

var arrow = preload("res://arrow.tscn")
var health = 3
var startPoint: Vector2
var currentlyInStage: int = 1 
var currentlyMoving = false

var rangeOfMovement = 180
var dir: Vector2

@export var bossSpeed = 110
var distanceCovered = 0

var bossActivated = true

var waiting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	startPoint = global_position

func _process(delta):
	if health <= 0:
		queue_free()

#	
#	# 	4 stages of movement:
#	# 1. randomize direction and go to that direction
#	# 2. shoot cluster of arrows
#	# 3. go back to the starting point
#	# 4. shoot arrows in a circle
#

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if bossActivated:
		match currentlyInStage: # switch/case 
			1:
				if not currentlyMoving: # move only when on screen:
					# randomise direction
					dir.x = randf_range(-1, 1)
					dir.y = randf_range(-1, 1)
					dir = dir.normalized()
					currentlyMoving = true
				else:
					distanceCovered += delta * bossSpeed
					position += dir * delta * bossSpeed
					if distanceCovered >= rangeOfMovement:
						currentlyMoving = false
						currentlyInStage = 2
						distanceCovered = 0
			2:
				if not waiting:
					for i in range(-1, 2):
						var projectile = arrow.instantiate()
						projectile.set_offset(i)
						get_node("/root").add_child(projectile)
						projectile.transform = global_transform
					$PauseInMovement.start(1)
					waiting = true
			3:
				if not currentlyMoving:
					#dir = (startPoint - global_position).normalized()
					currentlyMoving = true
				else:
					distanceCovered += delta * bossSpeed
					position -= dir * delta * bossSpeed
					if distanceCovered >= rangeOfMovement:
						currentlyMoving = false
						currentlyInStage = 4
						distanceCovered = 0
			4:
				if not waiting:
					for i in range(-4, 4):
						var projectile = arrow.instantiate()
						projectile.set_offset(i)
						get_node("/root").add_child(projectile)
						projectile.transform = global_transform
					$PauseInMovement.start(2)
					waiting = true
 

func _on_shooting_cd_timeout():
	currentlyInStage += 1
	if currentlyInStage >= 5:
		currentlyInStage = 1
	waiting = false
