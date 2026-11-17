class_name PickableObj
extends Node3D

@export var objName: String
@export var objLink: String
@export var isInteractable: bool

func pickup():
	queue_free()
	
func send_message():
	pass
