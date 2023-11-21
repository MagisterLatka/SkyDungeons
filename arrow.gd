extends Area2D

@export var bulletSpeed = 140.0
var dir
var dir_norm
var Player
var set_settings = false
var offset: int = 0

func set_offset(arg: int):
	offset = arg * 45

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().position
	Player = get_parent().get_node("Level0/Player1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not set_settings:
		dir = (Player.global_position - Vector2(global_position))
		dir_norm = dir.normalized().rotated(deg_to_rad(offset))	
		rotation = position.angle_to_point(Player.position) + deg_to_rad(offset)
		set_settings = true
	position += dir_norm * delta * bulletSpeed 

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func on_hit_with_entity():
	queue_free()
