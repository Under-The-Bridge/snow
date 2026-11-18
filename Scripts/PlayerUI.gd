extends Node

@export var inventory: VBoxContainer
@export var player: CharacterBody3D
@export var item_label: Label
@export var inventory_items: VBoxContainer

var tween = create_tween()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('tab'):
		update_inventory()
		inventory.slide(!inventory.isOpen)

func update_inventory():
	var items = InventoryManager.inventory
	for i in inventory_items.get_children():
		if(i.visible == true):
			i.queue_free()
	for i in items:
		var temp_item = item_label.duplicate()
		inventory_items.add_child(temp_item)
		temp_item.text = InventoryManager.items[i]["name"] + ": " + str(items[i]) + " шт."
		temp_item.show();
