extends Area2D





func _on_body_entered(body):
	if Game.get_keys() > 0:
		Game.reduce_key()
		get_node("Lock").queue_free()
		print("odblokowane")
	else:
		print("zablokowane")
