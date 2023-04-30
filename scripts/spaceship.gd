extends RigidBody2D
@export var acceleration: float = 3000000000000000
@export var rotation_speed: float = 150
@export var max_speed: float = 10000
@export var max_health: int = 3

signal slowdown(amount: float, body: Node2D)
signal damage(amount: float, body: Node2D)

var max_speed_vec = Vector2(max_speed, max_speed)
var reverse_max_speed_vec = -max_speed_vec
var velocity_slowdown = 0
var health = max_health

@onready var left_back_thruster: CPUParticles2D = $LeftBack
@onready var right_back_thruster: CPUParticles2D = $RightBack
@onready var left_front_thruster: CPUParticles2D = $LeftFront
@onready var right_front_thruster: CPUParticles2D = $RightFront

@onready var spawn_point = get_node("/root/space/Spawn")

func _handle_slowdown(amount: float, body: Node2D):
	if body != self:
		print(body, " was slowdown by ", amount)
		return
	velocity_slowdown = max(amount, velocity_slowdown)

func _handle_damage(amount: int, body: Node2D):
	if body != self:
		print(body, " was damaged by ", amount)
		return
	health -= amount
	print(health)

func _respawn():
	global_position = spawn_point.global_position
	health = max_health
	linear_velocity = Vector2.ZERO
	velocity_slowdown = 0

func _ready():
	_respawn()
	left_back_thruster.emitting = false
	right_back_thruster.emitting = false
	left_front_thruster.emitting = false
	right_front_thruster.emitting = false
	
	slowdown.connect(_handle_slowdown)
	damage.connect(_handle_damage)

func _physics_process(delta):
	if global_position.length() > 20000:
		_respawn()

	var rotation_dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	var thrust = Input.get_action_strength("forward")
	var slow = Input.get_action_strength("backward")

	rotation_degrees += rotation_speed * rotation_dir * delta

	var forward_dir = Vector2(cos(rotation), sin(rotation))

	if thrust > 0:
		handle_thrust(forward_dir, delta)
	elif slow > 0:
		handle_slow(forward_dir, delta)
	else:
		_stop()

	velocity_slowdown = max(0, velocity_slowdown - delta)
	print(linear_velocity)


func _forward():
	left_front_thruster.emitting = false
	right_front_thruster.emitting = false
	left_back_thruster.emitting = true
	right_back_thruster.emitting = true
	
func _backward():
	left_front_thruster.emitting = true
	right_front_thruster.emitting = true
	left_back_thruster.emitting = false
	right_back_thruster.emitting = false

func _left():
	left_front_thruster.emitting = true
	right_front_thruster.emitting = false
	left_back_thruster.emitting = false
	right_back_thruster.emitting = true

func _right():
	left_front_thruster.emitting = false
	right_front_thruster.emitting = true
	left_back_thruster.emitting = true
	right_back_thruster.emitting = false

func _stop():
	left_back_thruster.emitting = false
	right_back_thruster.emitting = false
	left_front_thruster.emitting = false
	right_front_thruster.emitting = false

func handle_thrust(forward_dir: Vector2, delta):
	var force = forward_dir * acceleration
	if velocity_slowdown > 1:
		force /= velocity_slowdown
	apply_central_force(force)
	#apply_force(force / 2, left_back_thruster.global_position - global_position)
	#apply_force(force / 2, right_back_thruster.global_position - global_position)
	_forward()


func handle_slow(forward_dir, delta):
	var force = -(forward_dir * acceleration)
	if velocity_slowdown > 1:
		force /= velocity_slowdown
	apply_central_force(force)
	#apply_force(force / 2, left_front_thruster.global_position - global_position)
	#apply_force(force / 2, right_front_thruster.global_position - global_position)
	_backward()

func handle_no_input(forward_dir, delta):
	var value = linear_velocity.dot(forward_dir)
	var side = linear_velocity.rotated(90).dot(forward_dir)
	if value > 0.5:
		_backward()
	elif value < -0.5:
		_forward()
	elif value < 0:
		if side > 0:
			_left()
		else:
			_right()
	elif value > 0:
		if side < 0:
			_left()
		else:
			_right()
	else:
		_stop()


func _on_main_assigment_area_body_entered(body):
	print("entered", body.name)
	pass # Replace with function body.


func _on_main_assigment_area_body_exited(body):
	print("exited", body.name)
	pass # Replace with function body.
