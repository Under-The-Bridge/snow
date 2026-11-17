extends Node

@export var animationPlayer: AnimationPlayer

@export var message_box: Label

var current_anim = ''

func _ready() -> void:
	animationPlayer.play('car_animation')
	current_anim = 'car_animation'
	message_box.show_message("Пропустить ESC")

func _input(event: InputEvent) -> void:
	if event.is_action_released('esc'):
		end_anim()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "car_animation":
		end_anim()

func end_anim():
	SceneManager.loadScene('game')
