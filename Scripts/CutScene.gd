extends Node

@export var animationPlayer: AnimationPlayer

func _ready() -> void:
	animationPlayer.play('car_animation')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "car_animation":
		SceneManager.loadScene('game')
