extends Area

func _on_Area_body_entered(body):
	if body.has_method('crash'):
		body.crash()
