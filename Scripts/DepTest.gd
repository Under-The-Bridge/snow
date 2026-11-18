extends UniquePickableItems



func pickup():
	pass
	
func uniqueInteract():
	if(InventoryManager.remove_item('pickable_test_box',1)):
		await DialogueManager.show_notification('вы потратили куб')
	else:
		await DialogueManager.show_notification('у вас нет кубов')
