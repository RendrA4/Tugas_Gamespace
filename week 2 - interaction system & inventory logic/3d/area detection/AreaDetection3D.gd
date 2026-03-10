class_name AreaDetection3D
extends Area3D

var current_closest_item: Node3D = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if current_closest_item and current_closest_item.has_method("collect"):
			current_closest_item.collect()
			current_closest_item = null

func _process(_delta: float) -> void:
	_update_closest_item()

func _update_closest_item() -> void:
	var items = get_overlapping_bodies()
	if items.is_empty():
		return
	
	var closest_item = null
	var min_distance = INF # nilai tak hingga untuk sementara
	
	for body in items:
		if body.has_method("collect"):
			# mendapatkan jarak antara player dengan item
			var distance = global_position.distance_to(body.global_position)
			if distance < min_distance: 
				min_distance = distance
				closest_item = body
	
	if current_closest_item != closest_item:
		# panggil fungsi undetected() pada item lama
		if current_closest_item and is_instance_valid(current_closest_item):
			if current_closest_item.has_method("undetected"):
				current_closest_item.undetected()
		
		# assign item terdekat sekarang dengan yang baru
		current_closest_item = closest_item
		# panggil fungsi detected() pada item baru
		if current_closest_item and current_closest_item.has_method("detected"):
			current_closest_item.detected()
