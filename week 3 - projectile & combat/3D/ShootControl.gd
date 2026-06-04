class_name ShootControl
extends Node

@export var effect: MeshInstance3D = null

func _ready() -> void:
	effect.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		effect.show()
		await get_tree().create_timer(0.1).timeout
		effect.hide()
