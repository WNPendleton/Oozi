extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/cutscene00.tscn")


func _on_return_button_pressed():
	$Credits.hide()
	$Main.show()


func _on_credits_button_pressed():
	$Credits.show()
	$Main.hide()
