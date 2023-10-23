extends Actor3D

@export var speed = 1.0
@export var move_range = 2.0
@export var pulse_speed = 2.0
@export var pulse_range = 0.2
@export var face_wobbliness = 0.2

@onready var base_height = transform.origin.y

var start_delay = 0.2
var time = 0

func _process(delta):
	if start_delay > 0:
		start_delay -= delta
		return
	script_process(delta)
	time += delta
	var pulse_amount = sin(time * pulse_speed)
	$Core.transform.origin.y = base_height + (pulse_amount * pulse_range)
	$Face.transform.origin.y = base_height + (pulse_amount * pulse_range * face_wobbliness)
	if abs(transform.origin.x) > move_range:
		speed = -speed
