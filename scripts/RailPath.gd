@tool
extends Path3D

@export var distance_between_planks : float = 1.0

var dirty = false

func _process(delta):
	if dirty:
		update_multimesh()

func update_multimesh():
	print("updating")
	dirty = false
	var path_length : float = curve.get_baked_length()
	var count = floor(path_length / distance_between_planks)
	var mm1 : MultiMesh = $Tracks/LeftTrack/Planks.multimesh
	var mm2 : MultiMesh = $Tracks/MiddleTrack/Planks.multimesh
	var mm3 : MultiMesh = $Tracks/RightTrack/Planks.multimesh
	for mm in [mm1, mm2, mm3]:
		mm.instance_count = count
		var offset = distance_between_planks / 2.0
		for i in range(0, count):
			var curve_distance = offset + distance_between_planks * i
			var position = curve.sample_baked(curve_distance, true)
			var basis = Basis()
			var up = curve.sample_baked_up_vector(curve_distance, true)
			var forward = position.direction_to(curve.sample_baked(curve_distance + 0.1, true))
			basis.y = up
			basis.x = forward.cross(up).normalized()
			basis.z = -forward
			var transform = Transform3D(basis, position)
			mm.set_instance_transform(i, transform)

func _on_curve_changed():
	dirty = true
