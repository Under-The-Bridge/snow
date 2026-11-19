extends Control

@export var settings_menu: Control

func _on_play_pressed() -> void:
	SceneManager.loadScene('loading')


func _on_settings_pressed() -> void:
	open_settings()


func _on_quit_pressed() -> void:
	SceneManager.quit()


func _on_h_slider_value_changed(value: float) -> void:
	pass


func _on_close_settings_pressed() -> void:
	open_settings()
	
func open_settings():
	settings_menu.visible = !settings_menu.visible
