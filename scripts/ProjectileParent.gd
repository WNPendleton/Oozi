extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerPathGetter.projectile_parent_path = get_path()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
