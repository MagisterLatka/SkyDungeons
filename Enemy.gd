extends CharacterBody2D

@export var enemySpeed = 195.0

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0.0, enemySpeed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	move_and_slide()
