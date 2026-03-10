# InventoryManager.gd
extends Node

signal add_to_inventory(item_name: String ,data: Dictionary[String, ItemData])

var inventory : Dictionary[String, ItemData] = {}

func get_coin() -> int:
	var total_coin: int = 0
	for item_res in inventory.values():
		if item_res.type == 0:
			total_coin += item_res.value * item_res.amount
	
	return total_coin

func _ready() -> void:
	add_to_inventory.connect(_on_add_to_inventory)

func _on_add_to_inventory(item_name: String, data: Dictionary[String, ItemData]) -> void:
	if inventory.get(item_name):
		inventory[item_name].amount += 1
		#print("tambah amount " + str(inventory[item_name].amount))
	else:
		inventory.merge(data)
		#print("tambah key " + str(inventory.keys()))
