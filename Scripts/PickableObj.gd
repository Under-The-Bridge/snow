class_name PickableObj
extends Node3D

@export var objName: String
@export var objLink: String
@export var message: String
@export var isInteractable: bool

func pickup():
	send_message()
	queue_free()
	
func send_message():
	if message != '': 
		DialogueManager.show_message(message)
	
