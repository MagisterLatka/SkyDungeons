extends Area2D

var arrow = preload("res://arrow.tscn")
var health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		queue_free()


func _on_shooting_cd_timeout():
	if $VisibleOnScreenNotifier2D.is_on_screen():
		var projectile = arrow.instantiate()
		projectile.set_offset(0)
		get_node("/root").add_child(projectile)
		projectile.transform = global_transform
