extends VBoxContainer

var start_position: Vector2
var tween: Tween
var isOpen = false

func _ready() -> void:
	start_position = position

func slide(open: bool) -> void:
	isOpen = open
	if tween:
		tween.kill()

	var target = start_position
	if open:
		target += Vector2(-400, 0)

	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", target, 0.3)
