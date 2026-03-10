class_name RayDetector3D
extends RayCast3D

var current_target: Item3D = null

func _physics_process(_delta: float) -> void:
	if is_colliding():
		var hit_object = get_collider() as Item3D
		if hit_object == null:
			return 
		
		# jika current target bukan hit object
		if current_target != hit_object:
			if is_instance_valid(current_target) and current_target.has_method("undetected"):
				current_target.undetected() # di set ke undected dulu
			
			current_target = hit_object 
			if is_instance_valid(current_target) and current_target.has_method("detected"):
				current_target.detected() # set ke detected ketika sudah disi oleh hit object
			
		if Input.is_action_just_pressed("interact"):
			if current_target.has_method("collect"):
				current_target.collect()
				current_target = null 

	else:
		if current_target != null:
			if current_target.has_method("undetected"):
				current_target.undetected()
			current_target = null
