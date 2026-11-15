extends CharacterBody3D

@export var speed: float = 4.5
@export var speed_run: float = 20
@export var camera: Node3D
@export var flashlight: SpotLight3D

@export var inventory  = []
@export var ui: CanvasLayer

var headFloat = 0.0
var flashlightOn = false

func _physics_process(delta: float) -> void:
	
	camera.position = Vector3(0,2.25 + (sin(headFloat) / 6),0)
	
	var input = Input.get_vector("a", "d", "w", "s")
	var direction = camera.global_basis * Vector3(input.x, 0, input.y)
	
	direction.y = 0
	direction = direction.normalized()
	
	if Input.is_action_pressed('shift'):
		velocity.x = direction.x * speed_run
		velocity.z = direction.z * speed_run
	else:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	
	if direction != Vector3.ZERO:
		headFloat += delta * 10
	else:
		headFloat = 0
	
	
	if Input.is_action_just_pressed("f"):
		flashOn()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

func flashOn():
	flashlightOn = !flashlightOn
	flashlight.visible = flashlightOn

func add_object_to_inventory(obj):
	var item_name = obj.objName
	
	for i in inventory:
		if item_name == i[0]:
			i[1] += 1
			ui.update_inventory()
			return
	inventory.append([item_name,1])
	ui.update_inventory()
