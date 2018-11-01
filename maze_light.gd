extends RayCast

func _ready():
	hide()
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	if !is_colliding():
		show()
