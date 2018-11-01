extends GridMap

var block = preload("res://maze_block.tscn")

func _ready():
	yield(get_tree(),"idle_frame")
	var cells = get_used_cells()
	for cell in cells:
		var b = block.instance()
		get_parent().add_child(b)
		b.translation = map_to_world(cell.x, cell.y, cell.z)
	hide()


