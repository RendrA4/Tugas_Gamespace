class_name RaycastDetection2D
extends RayCast2D

@export var player: Player2D


func _process(_delta: float) -> void:
	change_target_direction()


func _physics_process(_delta: float) -> void:
	if is_colliding():

		var target = get_collider()

		if target is Area2D:

			var parent = target.get_parent()

			if parent is Item2D:
				parent.collect()

			if parent is LightSwitch:
				if Input.is_action_just_pressed("interact"):
					parent.toggle_light()


func change_target_direction() -> void:

	if player.get_direction() < 0:
		target_position.x = -70

	elif player.get_direction() > 0:
		target_position.x = 70
