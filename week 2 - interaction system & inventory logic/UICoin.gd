class_name UICoin
extends Control

@onready var label: Label = $Label

func _process(_delta: float) -> void:
	label.text = ": " + str(InventoryManager.get_coin())
