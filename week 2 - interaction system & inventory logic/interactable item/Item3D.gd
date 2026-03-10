class_name Item3D
extends StaticBody3D

@export var item_data: ItemData = null
@export var mesh: MeshInstance3D = null
@export var viscue_text: Label = null

var item_dict: Dictionary[String, ItemData] = {}
var origin_material: StandardMaterial3D
var unique_material: StandardMaterial3D

func _ready() -> void:
	item_dict = {
		item_data.name : item_data
	}
	
	origin_material = mesh.get_surface_override_material(0)
	unique_material = origin_material.duplicate()
	mesh.set_surface_override_material(0, unique_material)
	
	undetected()

func detected() -> void:
	viscue_text.show()
	viscue_text.text = "E : " + item_data.name
	unique_material.stencil_outline_thickness = 0.04
	unique_material.emission_energy_multiplier = 0.25

func undetected() -> void:
	viscue_text.hide()
	unique_material.stencil_outline_thickness = 0.01
	unique_material.emission_energy_multiplier = 0.0

func collect() -> void:
	InventoryManager.add_to_inventory.emit(item_data.name, item_dict)
	queue_free()
