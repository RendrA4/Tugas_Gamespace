class_name Item2D
extends Node2D
## class digunakan sebagai template untuk setiap item yang ada
"res://week 2 - interaction system & inventory logic/2d/area detection/PB2DAreaDetection.tscn"

@export var item_data: ItemData = null
@export var area_checker: AreaChecker2D = null

var item_dict: Dictionary[String, ItemData] = {}

func get_item_dict() -> Dictionary:
	return item_dict

func get_item_name() -> String:
	return item_data.name

func _ready() -> void:
	item_dict = {
		item_data.name : item_data,
	}

func _process(_delta: float) -> void:
	if area_checker.is_body_enter_area():
		collect()

func collect() -> void:
	InventoryManager.add_to_inventory.emit(item_data.name, item_dict)
	queue_free()
