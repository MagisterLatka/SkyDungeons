extends Label

var speed = 0.1
var time = 0.0

func _process(delta):
	if ((time >= 0.0 and time <= 2.0) or (time >= 3.0 and time <= 7.2) or (time >= 8.5 and time <= 9.0)
	or (time >= 13.0)):
		self.visible_ratio = clamp(self.visible_ratio + 1.0 / self.text.length() * speed, 0.0, 1.0)
	if (self.visible_ratio >= 0.99):
		get_parent().get_node("Button").visible = true
		
	time += delta
	