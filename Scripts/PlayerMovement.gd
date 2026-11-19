extends CharacterBody3D

@export var speed: float = 4.5
@export var speed_run: float = 20
@export var camera: Camera3D
@export var flashlight: SpotLight3D
@export var jump_velocity: float = 5.0
@export var collision: CollisionShape3D
@export var ui: CanvasLayer
@export var flash_enable = false
@export var chainsaw_enable = false
@export var flashlightModel: Node3D
@export var chainsawModel: Node3D
@export var phone: Node3D

var headFloat = 0.0
var flashlightOn = false
var tween = create_tween()
var collisionHeigh = 0

func _ready() -> void:
	collisionHeigh = collision.shape.height

func _physics_process(delta: float) -> void:
	
	camera.v_offset = sin(headFloat) / 25
	
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
	
	
	if Input.is_action_just_pressed("f") and flash_enable:
		flashOn()
	
	if not is_on_floor():
		velocity += get_gravity() * delta * 5

	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump_velocity
	
	move_and_slide()

func enabe_chainsaw():
	chainsaw_enable = true
	chainsawModel.show()

func flashOn():
	flashlightOn = !flashlightOn
	flashlight.visible = flashlightOn

func add_object_to_inventory(obj):
	if obj is UniquePickableItems:
		obj.uniqueInteract()
		return
	InventoryManager.add_item(obj.objLink,1)
	ui.update_inventory()

func enable_flashlight():
	flash_enable = true
	#flashlightModel.show()

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("r"):
		phone.take_screen()
	
	var target_height: float
	
	if event.is_action_pressed("ctrl") and not event.is_echo():
		target_height = 2
	elif event.is_action_released("ctrl"):
		target_height = collisionHeigh
	else:
		return

	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(collision.shape, "height", target_height, 0.1)
