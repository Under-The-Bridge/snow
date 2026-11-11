extends Node

func _on_play_pressed() -> void:
	SceneManager.loadScene('game')


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	SceneManager.quit()


func _on_h_slider_value_changed(value: float) -> void:
	pass
