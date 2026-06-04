class_name HealthBar3D
extends ProgressBar

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	max_value = player.max_health

func _process(_delta: float) -> void:
	if player.has_method("get_current_health"):
		value = player.get_current_health()
