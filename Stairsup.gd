extends Area2D





func _on_body_entered(body):
	if Game.get_keys() > 0:
		Game.reduce_key()
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(get_node("Lock"), "modulate:a", 0, 0.5)
		tween1.tween_property(get_node("Lock"), "position", get_node("Lock").position - Vector2(0,100), 1)
		tween1.tween_callback(get_node("Lock").queue_free)
		get_node("Timer1").start()


func _on_timer_timeout():
	Game.change_level()
