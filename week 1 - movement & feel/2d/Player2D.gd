class_name Player2D
extends CharacterBody2D
## Player Class
##
## Player class digunakan untuk mengontrol semua pergerakan dari player. Mulai dari jump, move, dll.
@export var animation: AnimatedSprite2D = null
@export var grapple_ray: RayCast2D
@export var grapple_speed: float = 800
@onready var rope = $Line2D

@export_group("Player Data")
@export var move_speed: float = 0
@export var jump_force: float = 0
@export var friction: float = 0
@export var acceleration: float = 0

@export_group("Movement Multiplier")
@export var gravity_mult: float = 0
@export var speed_mult: float = 0
@export var jump_mult : float = 0

@export_group("Movement Feel")
@export var coyote_time: float = 0
@export var jump_buffer: float = 0

var _direction: float = 0
var _coyote_timer: float = 0
var _jump_buffer_timer: float = 0
var is_grappling = false
var grapple_point: Vector2

func get_direction() -> float:
	return _direction

## Fungsi Process ini digunakan untuk memproses game secara terus menerus tanpa henti
## sampai game dihentikan
func _process(_delta: float) -> void:
	_animation()

## Fungsi Physics Process digunakan untuk memproses game secara terus menerus juga, namun di fungsi ini
## ada tambahan proses fisika (Grivtasi, Velocity, dll)
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * gravity_mult
		_coyote_timer -= delta
	else:
		_coyote_timer = coyote_time
	
	if Input.is_action_just_pressed("jump"):
		_jump_buffer_timer = jump_buffer
	
	_jump_buffer_timer -= delta
	
	_jump()
	_move()
	_grapple(delta)
	move_and_slide() ## (PENTING !!) fungsi untuk meng eksekusi proses fisika

## fungsi buatan sendiri yang mengatur move
func _move() -> void:
	_direction = Input.get_axis("left", "right")
	if _direction != 0:
		# velocity itu hasil kali dari arah dan kecepatan
		velocity.x = move_toward(velocity.x, move_speed * _direction * speed_mult, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)

## fungsi buatan sendiri yang mengatur jump
func _jump() -> void:
	if _jump_buffer_timer > 0 and _coyote_timer > 0:
		velocity.y = -jump_force * jump_mult
		_jump_buffer_timer = 0
		_coyote_timer = 0
		
@warning_ignore("unused_parameter")
func _grapple(delta) -> void:

	if Input.is_action_just_pressed("grapple"):
		if grapple_ray.is_colliding():
			is_grappling = true
			grapple_point = grapple_ray.get_collision_point()

	if Input.is_action_just_released("grapple"):
		is_grappling = false
		rope.clear_points()

	if is_grappling:
		var direction = (grapple_point - global_position).normalized()
		velocity = direction * grapple_speed

		# gambar tali
		rope.points = [Vector2(0,-20), to_local(grapple_point)]

		if global_position.distance_to(grapple_point) < 10:
			is_grappling = false
			rope.clear_points()

## fungsi buatan sendiri yang mengatur animasi player
func _animation() -> void:
	if is_on_floor():
		if _direction != 0:
			animation.play("Move")
		else:
			animation.play("Idle")
	else:
		if velocity.y > 0:
			animation.play("Fall")
		elif velocity.y < 0:
			animation.play("Jump")
	
	_facing_direction()

## fungsi buatan sendiri yang mengatur tatapn animasi karakter
func _facing_direction() -> void:
	if _direction > 0:
		animation.flip_h = false
		grapple_ray.target_position.x = 200
	elif _direction < 0:
		animation.flip_h = true
		grapple_ray.target_position.x = -200
