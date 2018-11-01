extends ColorRect

var alpha = 0

func _process(delta):
	alpha += delta /  10.0
	if alpha > 1:
		alpha = 1
	$Label.set_modulate(Color(1,1,1,alpha))
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://world.tscn")
	if Input.is_action_pressed("exit"):
		get_tree().quit()
