@tool
extends Path3D

@export var distance_between_planks : float = 1.0

var dirty = false

func _process(_delta):
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
			var mesh_position = curve.sample_baked(curve_distance, true)
			var mesh_basis = Basis()
			var up = curve.sample_baked_up_vector(curve_distance, true)
			var forward = mesh_position.direction_to(curve.sample_baked(curve_distance + 0.1, true))
			mesh_basis.y = up
			mesh_basis.x = forward.cross(up).normalized()
			mesh_basis.z = -forward
			var mesh_transform = Transform3D(mesh_basis, mesh_position)
			mm.set_instance_transform(i, mesh_transform)

func _on_curve_changed():
	dirty = true
