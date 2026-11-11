extends CharacterBody3D

@export var speed: float = 4.5
@export var camera: Node3D

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("a", "d", "w", "s")
	var direction = camera.global_basis * Vector3(input.x, 0, input.y)
	
	direction.y = 0
	direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
