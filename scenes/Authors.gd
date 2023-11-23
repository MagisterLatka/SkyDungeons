extends Button

func _on_pressed():
	get_parent().get_node("Credit").visible = true
