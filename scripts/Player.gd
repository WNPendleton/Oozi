extends CharacterBody3D

@export var arm_range : Vector2
@export var arm_base : Vector2

var init_counter = 0.2

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var mouse_pos = get_viewport().get_mouse_position()
	var screen_size = get_viewport().size
	# Sometimes the viewmodel will become misaligned based on initial mouse
	# position while loading scene. This 0.2 sec delay before tracking
	# the viewmodel to the mouse prevents this bug.
	if init_counter > 0:
		init_counter -= delta
		mouse_pos = Vector2(screen_size.x, 0)
	var mouse_offset = Vector2(float(mouse_pos.x)/screen_size.x-0.5, float(mouse_pos.y)/screen_size.y-0.5)
	$ArmAnchor.transform.basis = Basis()
	$ArmAnchor.rotate_object_local(Vector3(0,1,0), arm_base.x - (arm_range.x * mouse_offset.x))
	$ArmAnchor.rotate_object_local(Vector3(1,0,0), arm_base.y - (arm_range.y * mouse_offset.y))
