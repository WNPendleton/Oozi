extends CPUParticles3D

func _ready():
	emitting = true

func _process(_delta):
	if not is_emitting():
		queue_free()
