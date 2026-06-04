## Base class untuk logika dasar musuh.
## Mengelola inisialisasi group, kematian, rotasi senjata, dan logika menembak (Turret).
class_name EnemyBase
extends CharacterBody2D

# --- Export Variables ---
## Kecepatan jalan musuh.
@export var speed: float = 200.0 
## Referensi ke komponen senjata musuh.
@export var weapon: WeaponComponent = null
## Referensi ke komponen kesehatan musuh.
@export var health_component: HealthComponent = null
## Referensi ke NavigationAgent2D untuk pathfinding.
@export var nav_agent: NavigationAgent2D = null
## Slot untuk memasukkan file peluru dari Inspector.
@export var bullet_scene: PackedScene 

# --- Private Variables ---
var player = null
var last_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Menambahkan musuh ke grup agar bisa dikenali sistem lain
	add_to_group("enemy")
	
	# Menghubungkan signal kematian dari HealthComponent
	if health_component:
		health_component.died.connect(_on_died)
	
	# Memastikan Timer menembak sudah ada dan tersambung otomatis
	if has_node("ShootTimer"):
		var timer = $ShootTimer
		if not timer.timeout.is_connected(_on_shoot_timer_timeout):
			timer.timeout.connect(_on_shoot_timer_timeout)

func _physics_process(delta: float) -> void:
	# Menyimpan posisi terakhir untuk keperluan spawn koin saat mati
	last_pos = global_position
	
	# 1. Logika Rotasi Senjata
	if player and weapon:
		# Jika ada pemain di radar, arahkan senjata ke pemain
		var target_dir = (player.global_position - global_position).normalized()
		weapon.update_rotation(target_dir, delta)
	elif velocity.length() > 0 and weapon:
		# Jika tidak ada pemain tapi sedang bergerak, arahkan ke arah jalan
		weapon.update_rotation(velocity.normalized(), delta)
	
	# Melakukan pergerakan fisik
	move_and_slide()

# --- Logika Deteksi (Area2D) ---
# Hubungkan signal 'body_entered' dari node Area2D kamu ke fungsi ini
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		if has_node("ShootTimer"):
			$ShootTimer.start()
		print("Enemy: Target dikunci!")

# Hubungkan signal 'body_exited' dari node Area2D kamu ke fungsi ini
func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		if has_node("ShootTimer"):
			$ShootTimer.stop()
		print("Enemy: Target hilang!")

# --- Logika Menembak ---
func _on_shoot_timer_timeout() -> void:
	if player:
		shoot()

func shoot() -> void:
	if bullet_scene and weapon:
		var bullet = bullet_scene.instantiate()
		# Menambahkan peluru ke scene utama agar tidak ikut berputar dengan musuh
		get_tree().current_scene.add_child(bullet)
		
		# Mengatur posisi peluru di titik senjata
		bullet.global_position = weapon.global_position
		bullet.rotation = weapon.rotation

# --- Logika Damage & Kematian ---
func take_damage(amount: float) -> void:
	if health_component:
		health_component.take_damage(amount)

func _on_died() -> void:
	# Menghentikan gerakan agar posisi spawn koin akurat
	velocity = Vector2.ZERO 
	
	# Menangani interaksi dengan GameManager (Global Autoload)
	# Menggunakan get_node_or_null untuk menghindari crash jika Autoload belum siap
	var gm = get_node_or_null("/root/GameManager")
	if gm:
		gm.register_killed_enemy(name)
		# Memicu signal spawn koin di lokasi terakhir musuh
		if gm.has_signal("spawn_coin"):
			gm.spawn_coin.emit(last_pos)
	else:
		print("Error: GameManager tidak ditemukan! Pastikan sudah terdaftar di Project Settings > Autoload.")
	
	# Menghapus musuh dari permainan
	queue_free()


@warning_ignore("unused_parameter")
func _on_hitbox_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
