extends StaticBody

var pressed = false

func press():
	if pressed:
		return
	$AudioStreamPlayer3D.stop()
	$Visuals/ButtonUp.hide()
	get_parent().press_button()
	pressed = true
