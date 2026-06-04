class_name CoinPool
extends Node2D

@export var coin_scene: PackedScene = null

func _ready() -> void:
	# Tugas CoinPool: Hanya mendaftarkan diri ke group saat game mulai
	add_to_group("PoolKoin")

# Tugas CoinPool: Hanya membuat objek koin baru saat dipanggil
func spawn_coin(posisi_mati: Vector2) -> void:
	if coin_scene == null:
		print("Peringatan: coin_scene belum dimasukkan di Inspector CoinPool!")
		return
		
	var koin_baru = coin_scene.instantiate()
	koin_baru.position = posisi_mati
	call_deferred("add_child", koin_baru)
