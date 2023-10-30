extends Control

@export var start_scene : PackedScene

func _on_button_pressed():
	get_tree().change_scene_to_packed(start_scene)
