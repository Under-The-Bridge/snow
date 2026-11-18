extends UniquePickableItems

func uniqueInteract():
	player.enabe_chainsaw()
	DialogueManager.show_message('убивать...')
