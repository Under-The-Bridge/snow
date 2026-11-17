extends Node3D

var tween: Tween

var start_pos: Vector3

@export var delay = 5
@export var direction = Vector3(0,0,550)

func _ready() -> void:
	start_pos = self.position
	tween = create_tween()
	tween.set_loops()
	drive_anim()

func drive_anim():
	tween.tween_interval(delay)
	tween.tween_property(self,'position',start_pos + direction,6)
	tween.tween_property(self,'position',start_pos,0)
