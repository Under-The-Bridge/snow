extends UniquePickableItems

func uniqueInteract():
	player.flash_enable = true
	player.flashlightModel.show()
	DialogueManager.show_multiple_text([
			['включить фонарик на F','n'],
			[3,'w'],
			['ОГО ФОНАРИК !!_!_!','t']
		])
