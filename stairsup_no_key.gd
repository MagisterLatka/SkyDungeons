extends Area2D




func _on_body_entered(body):

	get_node("Timer").start()
	
func _on_timer_timeout():

	Game.change_level()
