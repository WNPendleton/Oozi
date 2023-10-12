extends Control

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		var tree = get_tree()
		tree.paused = !tree.paused
		if tree.paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
