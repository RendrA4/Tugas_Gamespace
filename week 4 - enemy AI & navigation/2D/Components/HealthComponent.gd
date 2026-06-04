## Komponen untuk mengelola kesehatan (HP) objek.
##
## Mengatur nilai kesehatan saat ini, kesehatan maksimal, dan memancarkan sinyal saat terkena damage atau mati.
class_name HealthComponent
extends Node

## Dipancarkan saat kesehatan berubah secara lokal.
signal health_changed(current_health: float, max_health: float)
## Dipancarkan saat kesehatan mencapai nol.
signal died

## health maksimal objek.
@export var max_health: float = 100.0
## health objek saat ini.
@onready var current_health: float = max_health

func _ready() -> void:
	health_changed.emit(current_health, max_health)
	
	# Ambil node Autoload secara aman menggunakan get_node_or_null
	var signal_bus = get_node_or_null("/root/SignalBus")
	if signal_bus and signal_bus.has_signal("health_setup"):
		signal_bus.health_setup.emit(max_health)

## Mengurangi kesehatan objek sejumlah [param amount].
func take_damage(amount: float) -> void:
	current_health = clamp(current_health - amount, 0, max_health)
	health_changed.emit(current_health, max_health)
	
	# Kirim sinyal ke SignalBus secara aman agar Health Bar di HUD ikut berkurang
	var signal_bus = get_node_or_null("/root/SignalBus")
	if signal_bus and signal_bus.has_signal("health_changed"):
		signal_bus.health_changed.emit(current_health)
	
	if current_health <= 0:
		died.emit()

## Mengatur kesehatan objek secara langsung (digunakan oleh load system).
func set_health(amount: float) -> void:
	current_health = clamp(amount, 0, max_health)
	health_changed.emit(current_health, max_health)
	
	# Update signal bus untuk HUD secara aman
	var signal_bus = get_node_or_null("/root/SignalBus")
	if signal_bus and signal_bus.has_signal("health_changed"):
		signal_bus.health_changed.emit(current_health)
