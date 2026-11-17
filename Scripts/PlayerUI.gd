extends Node

@export var inventory: VBoxContainer
@export var player: CharacterBody3D
@export var item_label: Label
@export var inventory_items: VBoxContainer
@export var message_box: Label

var tween = create_tween()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('tab'):
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

func show_message(message: String):
	if tween:
		tween.kill()
	message_box.text = message
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(message_box,'position',Vector2(25,576),0.5)
	tween.tween_interval(4)
	tween.tween_property(message_box,'position',Vector2(-256,576),0.5)
	
	await tween.finished
	message_box.text = ''
