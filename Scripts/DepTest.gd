extends UniquePickableItems

func pickup():
	pass
	
func uniqueInteract():
	DialogueManager.show_notification('вы депнули куб')
