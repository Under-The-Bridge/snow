extends Camera3D

@export var sensitivity: float = 0.003
@export var canRotate = true
@onready var ray: RayCast3D = $RayCast3D
@export var objNameLabel: Label
@export var interactLabel: Label
@export var player: CharacterBody3D

var tween: Tween
var default_fov: float

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	default_fov = fov

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("q"):
		zoom(true)
	elif event.is_action_released("q"):
		zoom(false)
	if !canRotate:
		return
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * sensitivity
		rotation.x -= event.relative.y * sensitivity
		rotation.x = clamp(rotation.x, deg_to_rad(-89), deg_to_rad(89))
	

func _process(_delta: float) -> void:
	interactLabel.hide()
	objNameLabel.text = ""

	if not ray.is_colliding():
		return

	var collider = ray.get_collider()
	if not is_instance_valid(collider):
		return

	var object = collider.get_parent()
	if not is_instance_valid(object):
		return

	if not ("objName" in object) or not ("isInteractable" in object):
		return

	objNameLabel.text = str(object.objName)

	if not object.isInteractable:
		return

	interactLabel.show()

	if Input.is_action_just_pressed("e"):
		player.add_object_to_inventory(object)
		object.pickup()
		interactLabel.hide()
		objNameLabel.text = ""

func zoom(open: bool) -> void:
	if tween:
		tween.kill()

	var target = default_fov
	if open:
		target = default_fov * 0.4

	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "fov", target, 0.4)
