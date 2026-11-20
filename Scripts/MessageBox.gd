extends Label

var tween: Tween

func show_message(message: String):
	if tween:
		tween.kill()
	self.text = message
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,'position',Vector2(25,576),0.5)
	tween.tween_interval(4)
	tween.tween_property(self,'position',Vector2(-256,576),0.5)
	
	await tween.finished
	self.text = ''
