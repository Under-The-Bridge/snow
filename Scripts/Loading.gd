extends Control

var scene_path = "res://Scenes/cutscene_1.tscn"

func _ready() -> void:
	ResourceLoader.load_threaded_request(scene_path)

func _process(_delta: float) -> void:
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(scene_path, progress)

	if not progress.is_empty():
		$ProgressBar.value = progress[0] * 100

	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene = ResourceLoader.load_threaded_get(scene_path)
		get_tree().change_scene_to_packed(scene)
		set_process(false)
	elif status == ResourceLoader.THREAD_LOAD_FAILED:
		set_process(false)
		push_error("Не удалось загрузить сцену")
