class_name Turret
extends StaticBody3D

@export var projectile_scene: PackedScene = null
@export var projectile_speed: float = 10
@export var projectile_damage: float = 40
@export var spawn_time: float = 1

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var marker: Marker3D = $Marker3D
@onready var spawn_timer: Timer = $SpawnTimer
@onready var projectile_container: Node3D = $ProjectileContainer

var detect: bool = false

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timout)

func _process(_delta: float) -> void:
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider() is Player3D:
		if not detect:
			detect = true
			spawn_timer.start(spawn_time)
	else:
		if detect:
			detect = false
			spawn_timer.stop()

func _on_spawn_timer_timout() -> void:
	if detect:
		_shoot()
		spawn_timer.start(spawn_time)

func _shoot() -> void:
	var projectile = projectile_scene.instantiate() as Projectile3D
	projectile.setup_projectile(-projectile_speed, projectile_damage)
	projectile_container.add_child(projectile)
	
	projectile.position = marker.position
