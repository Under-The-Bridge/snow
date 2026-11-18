extends UniquePickableItems

const BLOOD = [
	preload("res://Pref/blood_decal.tscn"),
	preload("res://Pref/blood_decal1.tscn"),
	preload("res://Pref/blood_decal2.tscn"),
]

func  uniqueInteract():
	if !player.chainsaw_enable:
		DialogueManager.show_message("неа")
		return
	
	var query = PhysicsRayQueryParameters3D.create(
		global_position + Vector3.UP,
		global_position + Vector3.DOWN * 5.0
	)
	var hit = get_world_3d().direct_space_state.intersect_ray(query)
	if hit.is_empty():
		return

	var blood = BLOOD[randi_range(0,BLOOD.size() - 1)].instantiate()
	get_tree().current_scene.add_child(blood)
	blood.global_position = hit.position + Vector3(
	randf_range(-3, 3),
	0.02,
	randf_range(-3, 3)
	)
	blood.rotation.y = randf_range(0, TAU)
	
	queue_free()
