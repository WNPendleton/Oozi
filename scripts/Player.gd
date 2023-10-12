extends CharacterBody3D

@export var look_speed = 0.01
@export var max_rot_y = PI/2

var rot_x = 0
var rot_y = 0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

func _input(event):
	if event is InputEventMouseMotion:
		rot_x += event.relative.x * look_speed
		rot_y += event.relative.y * look_speed
		if rot_y > max_rot_y:
			rot_y = max_rot_y
		if rot_y < -max_rot_y:
			rot_y = -max_rot_y
		transform.basis = Basis()
		$Camera.transform.basis = Basis()
		rotate_object_local(Vector3(0,1,0), -rot_x)
		$Camera.rotate_object_local(Vector3(1,0,0), -rot_y)
