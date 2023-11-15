extends Area2D

@export var enemySpeed = 100.0
var dir
var dir_norm
var alpha
var speedVector = Vector2.ZERO
var V = 190 # enemy speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dir = ($"../Player1".global_position - global_position)
	if (sqrt( dir.x**2 + dir.y**2 ) <= 120):
		dir_norm = dir.normalized()
		position += dir_norm * delta * enemySpeed
