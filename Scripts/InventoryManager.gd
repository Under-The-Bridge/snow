extends Node


var items = {
	"pickable_test_box": {
		'name':'Тестовая коробка',
	}
}

var inventory = {}

func add_item(item_name: String, amount: int = 1):
	if inventory.has(item_name):
		inventory[item_name] += amount
	else:
		inventory[item_name] = amount

func remove_item(item_name: String, amount: int) -> bool:
	if inventory.has(item_name) and inventory[item_name] >= amount:
		inventory[item_name] -= amount
		if inventory[item_name] <= 0:
			inventory.erase(item_name)
		return true
	return false
