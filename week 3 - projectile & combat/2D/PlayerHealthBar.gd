class_name PlayerHealthBar
extends ProgressBar

@onready var player: Player2D = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	max_value = player.get_max_health()

func _process(delta: float) -> void:
	value = player.get_current_health()
