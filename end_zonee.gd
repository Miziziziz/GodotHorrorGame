extends Area

func _ready():
	connect("body_entered", self, "win")

func win(coll):
	if coll.name == "Player":
		get_tree().change_scene("res://win.tscn")
