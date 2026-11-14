extends Node

@export var inventory: VBoxContainer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('tab'):
		inventory.slide(!inventory.isOpen)
