class_name LightSwitch
extends Node2D

@export var room_light: CanvasModulate

var light_on: bool = true


func toggle_light() -> void:
	if room_light == null:
		return
	
	if light_on:
		room_light.color = Color(0.6, 0.6, 0.6)
	else:
		room_light.color = Color(1, 1, 1)

	light_on = !light_on
