extends Node3D

@export var speed = 1.0
@export var move_range = 2.0

var start_delay = 0.2

func _process(delta):
	if start_delay > 0:
		start_delay -= delta
		return
	transform.origin.x += speed * delta
	if abs(transform.origin.x) > move_range:
		speed = -speed
