extends Control

@export var label: Label
var number = 0
var lock: Node3D 

func _on_button_pressed() -> void:
	number -= 1 
	if number < 0:
		number = 9
	update_label()


func _on_button_2_pressed() -> void:
	number += 1 
	if number > 9:
		number = 0
	update_label()

func update_label():
	label.text = str(number)
	lock.check_password()
