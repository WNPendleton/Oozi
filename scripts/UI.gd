extends Control

var previous_mouse_mode

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		var tree = get_tree()
		tree.paused = !tree.paused
		if tree.paused:
			previous_mouse_mode = Input.mouse_mode
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = previous_mouse_mode
