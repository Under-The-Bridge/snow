extends Node


func loadScene(name: String):
	get_tree().change_scene_to_file("res://Scenes/" + name + ".tscn")

func quit():
	get_tree().quit()
