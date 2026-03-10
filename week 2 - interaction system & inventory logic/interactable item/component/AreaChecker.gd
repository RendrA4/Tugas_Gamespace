class_name AreaChecker2D
extends Area2D
## class area checker untuk mengecek apakah ada body yang masuk

@export var group_name: String = ""

var is_body_enter: bool = false

func is_body_enter_area() -> bool:
	return is_body_enter

func _ready() -> void:
	body_entered.connect(_on_body_enter)
	body_exited.connect(_on_body_exit)

func _on_body_enter(body: Node2D) -> void:
	if body.is_in_group(group_name):
		is_body_enter = true

func _on_body_exit(body: Node2D) -> void:
	if body.is_in_group(group_name):
		is_body_enter = false
