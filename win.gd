extends ColorRect


func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://world.tscn")
	if Input.is_action_pressed("exit"):
		get_tree().quit()
