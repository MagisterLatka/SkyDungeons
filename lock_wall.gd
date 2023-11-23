extends StaticBody2D

func _on_area_2d_body_entered(body):
	if Game.get_keys() > 0:
		Game.reduce_key()
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_property(get_node("CollisionShape2D2/Area2D/Lock"), "modulate:a", 0, 0.5)
		tween2.tween_property(get_node("CollisionShape2D2/Area2D/Wall"), "modulate:a", 0, 1)
		tween1.tween_property(get_node("CollisionShape2D2/Area2D/Lock"), "position", get_node("CollisionShape2D2/Area2D/Lock").position - Vector2(0,100), 1)
		tween1.tween_callback(get_node("CollisionShape2D2/Area2D/Lock").queue_free)
		tween2.tween_callback(self.queue_free)
		
		
		#body.transport_player()
		
	else:
		print("zablokowane")
