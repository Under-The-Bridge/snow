extends UniquePickableItems

@export var canvas: CanvasLayer
@export var NumberBox: Control
@export var NumberBoxParent: Control
@export var Camera: Camera3D
@export var answer = []
@export var numboxs = [
	
]

var password = [1,2,3]
var isFocused = false

func _ready() -> void:
	numboxs.append(NumberBox)
	NumberBox.lock = self
	for i in password.size() - 1:
		var temp = NumberBox.duplicate()
		NumberBoxParent.add_child(temp)
		numboxs.append(temp)
		temp.lock = self

func check_password():
	answer = []
	for i in numboxs:
		answer.append(i.number)
	
	if answer == password:
		print("открыл")

func focus():
	if isFocused:
		isFocused = false
		canvas.hide()
		player.camera.show()
		player.camera.mouse_lock_unlock()
		player.camera.canRotate = true
		Camera.current = false
		player.canPlay = true
	else:
		isFocused = true
		canvas.show()
		player.camera.hide()
		player.camera.mouse_lock_unlock()
		player.camera.canRotate = false
		Camera.current = true
		player.canPlay = false
		player.camera.interactLabel.hide()
		player.camera.objNameLabel.text = ""

func _input(event: InputEvent) -> void:
	if event.is_action_released('esc') and isFocused:
		focus()
		isInteractable = true

func uniqueInteract():
	focus()
	isInteractable = false
