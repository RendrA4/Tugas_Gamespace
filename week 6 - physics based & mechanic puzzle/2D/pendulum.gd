extends Node2D

@onready var static_body: StaticBody2D = $StaticBody2D
@onready var bola_besi: RigidBody2D = $BolaBesi
@onready var line_2d: Line2D = $Line2D

func _process(_delta: float) -> void:
	# Pastikan semua node yang dibutuhkan tersedia di scene
	if static_body and bola_besi and line_2d:
		# Bersihkan titik garis yang lama
		line_2d.clear_points()
		
		# Titik awal tali: ada di posisi global jangkar atas
		line_2d.add_point(static_body.global_position - global_position)
		
		# Titik akhir tali: mengikuti posisi global boks bawah yang berayun
		line_2d.add_point(bola_besi.global_position - global_position)
