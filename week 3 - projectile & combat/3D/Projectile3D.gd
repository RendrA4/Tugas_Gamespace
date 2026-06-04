class_name Projectile3D
extends Area3D

var projectile_damage: float = 0
var projectile_speed: float = 0
var limit: float = 3.5

func _ready() -> void:
	body_entered.connect(_on_body_enter)

func setup_projectile(speed: float, damage) -> void:
	projectile_damage = damage
	projectile_speed = speed

func _process(delta: float) -> void:
	if limit <= 0:
		queue_free()
	else:
		limit -= delta
	
	global_position.z += projectile_speed * delta

func _on_body_enter(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(5)
			queue_free()
