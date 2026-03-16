class_name Item2D
extends Node2D

@export var item_data: ItemData = null
@export var area_checker: AreaChecker2D = null
@export var is_light_switch: bool = false
@export var room_light: CanvasModulate

var light_on = true
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
	if is_light_switch:
		toggle_light()
		return

	InventoryManager.add_to_inventory.emit(item_data.name, item_dict)
	queue_free()

func toggle_light():
	if room_light == null:
		return

	if light_on:
		room_light.color = Color(0.6,0.6,0.6)
	else:
		room_light.color = Color(1,1,1)

	light_on = !light_on
