class_name DummyTarget3D
extends CharacterBody3D

@export var max_health: float = 100

@onready var health_bar: ProgressBar = $SubViewport/ProgressBar

var _current_health: float

func _ready() -> void:
	health_bar.max_value = max_health
	_current_health = max_health

func _process(_delta: float) -> void:
	if _current_health <= 0:
		queue_free()
	
	health_bar.value = _current_health

func take_damage(damage: float) -> void:
	_current_health -= damage
