extends UniquePickableItems

func uniqueInteract():
	player.enable_flashlight()
	DialogueManager.show_multiple_text([
			['включить фонарик на F','n'],
			[3,'w'],
			['ОГО ФОНАРИК !!_!_!','t']
		])
