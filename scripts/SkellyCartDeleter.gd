extends Node3D

func activate_encounter():
	get_parent().queue_free()
