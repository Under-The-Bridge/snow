extends CanvasLayer

@export var message_window: Control
@export var notification_window: Control
@export var text_label: Label
@export var notification_text_label: Label
@export var text_speed = 0.025
var tween: Tween
var start_pos_message_window: Vector2
var start_pos_notification_window: Vector2
var canSkip = false

func _ready() -> void:
	start_pos_message_window = message_window.position
	start_pos_notification_window = notification_window.position

func show_message(message: String):
	var text = ''
	if tween:
		tween.kill()
	text_label.text = message
	text_label.visible_characters = 0
	tween = create_tween()
	tween.tween_property(message_window,'position',start_pos_message_window - Vector2(0,128),0.2)
	tween.tween_property(
		text_label, "visible_characters",
		text_label.get_total_character_count(),
		text_label.get_total_character_count() * text_speed
	)
	tween.tween_interval(4)
	tween.tween_property(message_window,'position',start_pos_message_window + Vector2(0,128),0.2)
	await tween.finished
	text_label.text = ''
 
func show_notification(message: String):
	if tween:
		tween.kill()
	notification_text_label.text = message
	tween = create_tween()
	tween.tween_property(notification_window,'position',start_pos_notification_window + Vector2(288,0),0.2)
	tween.tween_interval(4)
	tween.tween_property(notification_window,'position',start_pos_notification_window - Vector2(288,0),0.2)
	await tween.finished
	notification_text_label.text = ''

func show_multiple_text(array: Array):
	for text in array:
		match text[1]:
			't':
				await show_message(text[0])
			'n':
				await show_notification(text[0])
			'w':
				await wait(text[0])

func wait(seconds: float):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_interval(seconds)
	await tween.finished
