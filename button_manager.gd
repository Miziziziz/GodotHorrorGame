extends Spatial

var buttons_to_press = 3
var buttons_pressed = 0

var door = null

func press_button():
	buttons_pressed += 1
	if buttons_pressed >= buttons_to_press:
		$Door.queue_free()
		$AudioStreamPlayer3D.play()
