extends KinematicBody

const MOVE_SPEED = 5
const MOUSE_SENS = 0.5

onready var rc = $RayCast
onready var text = $CanvasLayer/Label
var dead = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= deg2rad(event.relative.x * MOUSE_SENS)

func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()

func _physics_process(delta):
	var move_vec = Vector3()
	if Input.is_action_pressed("move_forward"):
		move_vec.z -= 1
	if Input.is_action_pressed("move_backward"):
		move_vec.z += 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	
	move_and_slide(MOVE_SPEED * move_vec)
	
	if rc.is_colliding():
		if Input.is_action_just_pressed("press_button"):
			rc.get_collider().press()
		if rc.get_collider().pressed:
			text.hide()
		else:
			text.show()
	else:
		text.hide()

func die():
	if dead:
		return
	dead = true
	get_tree().change_scene("res://dead.tscn")
