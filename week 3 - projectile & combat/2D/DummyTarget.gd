class_name DummyTarget
extends CharacterBody2D

@export var max_health: float = 100
# Tarik file peluru (.tscn) ke kolom ini di Inspector (sisi kanan)
@export var bullet_scene: PackedScene 

@onready var health_bar: ProgressBar = $HealthBar

var _current_health: float = 0
var target: Node2D = null

func _ready() -> void:
	_current_health = max_health
	health_bar.max_value = max_health
	# Pastikan ShootTimer tidak jalan sendiri di awal
	$ShootTimer.stop()

func _process(_delta: float) -> void:
	if _current_health <= 0:
		queue_free()
	
	health_bar.value = _current_health
	
	# Jika ada target, katak akan selalu menoleh ke arah target tersebut
	if target:
		look_at(target.global_position)

func take_damage(damage: float) -> void:
	_current_health -= damage

# Mekanik: Saat pemain masuk ke lingkaran Radar
func _on_radar_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("player"):
		target = body
		$ShootTimer.start() # Mulai jeda tembakan

# Mekanik: Saat pemain keluar dari lingkaran Radar
func _on_radar_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
		$ShootTimer.stop() # Berhenti menembak

# Mekanik: Setiap kali waktu di ShootTimer habis (1.5 detik)
func _on_shoot_timer_timeout() -> void:
	if target:
		shoot()

# Fungsi khusus untuk mengeluarkan peluru
func shoot() -> void:
	if bullet_scene:
		var b = bullet_scene.instantiate()
		# Menambahkan peluru ke dalam map game agar tidak ikut terhapus jika katak mati
		get_tree().root.add_child(b) 
		# Set posisi awal peluru di Marker2D
		b.global_position = $Marker2D.global_position
		# Set arah peluru sesuai arah hadap katak
		b.rotation = rotation
