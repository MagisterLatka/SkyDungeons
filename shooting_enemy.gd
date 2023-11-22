extends Area2D

var arrow = preload("res://arrow.tscn")
var health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var alpha = rad_to_deg(($"../Player1".global_position - global_position).normalized().angle())
	if (45 < alpha and alpha <= 135):
		$AnimatedSprite2D.frame = 0
	elif (135 < alpha or alpha <= -135):
		$AnimatedSprite2D.frame = 2
	elif (-135 < alpha and alpha <= -45):
		$AnimatedSprite2D.frame = 3
	else:
		$AnimatedSprite2D.frame = 1
		
	if health <= 0:
		queue_free()


func _on_shooting_cd_timeout():
	if $VisibleOnScreenNotifier2D.is_on_screen():
		var projectile = arrow.instantiate()
		projectile.set_offset(0)
		get_parent().add_child(projectile)
		projectile.transform = global_transform
		projectile.scale = Vector2(0.1, 0.1)

func take_damage(damage):
	health = health - damage
