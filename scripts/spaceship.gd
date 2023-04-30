extends RigidBody2D
@onready var cargoship_scene = preload("res://scenes/cargoship.tscn")
@export var spawn_offset: float = 80

@export var acceleration: float = 2000
@export var rotation_speed: float = 20000
@export var max_speed: float = 300



var max_speed_vec = Vector2(max_speed, max_speed)
var reverse_max_speed_vec = -max_speed_vec


@onready var left_back_thruster: CPUParticles2D = $LeftBack
@onready var right_back_thruster: CPUParticles2D = $RightBack
@onready var left_front_thruster: CPUParticles2D = $LeftFront
@onready var right_front_thruster: CPUParticles2D = $RightFront

@onready var spawn_point = get_node("/root/space/Spawn")


var cargo = []

func take_cargo(_cargo):
	if cargo.size() == 0:
		cargo = _cargo
		for type in cargo:
			var l = $Cargo.get_child_count()
			print(l)
			var parent = null
			if l == 0:
				parent = self
			else:
				parent = $Cargo.get_child(l - 1)
			
			var cargoship: Node2D = cargoship_scene.instantiate()
			$Cargo.add_child(cargoship)

			cargoship.global_rotation = parent.global_rotation
			var angle_vec = Vector2(cos(parent.global_rotation), sin(parent.global_rotation))
			cargoship.global_position = (parent.global_position - angle_vec * spawn_offset)
			cargoship.type = type
			cargoship.display()

			var joint = PinJoint2D.new()
			cargoship.add_child(joint)
			joint.set_softness(10)
			joint.set_bias(0.25)
			joint.global_position = (parent.global_position + cargoship.global_position) / 2
			joint.global_rotation = parent.global_rotation
			joint.set_node_a(parent.get_path())
			joint.set_node_b(cargoship.get_path())
			joint.set_exclude_nodes_from_collision(true)

func empty_cargo():
	for child in $Cargo.get_children():
		child.type = ''
		child.display()
	cargo = []

func drop_cargo():
	for child in $Cargo.get_children():
		$Cargo.remove_child(child)
		child.queue_free()
	cargo = []


func _respawn():
	global_position = spawn_point.global_position
	linear_velocity = Vector2.ZERO


func _ready():
	_respawn()
	left_back_thruster.emitting = false
	right_back_thruster.emitting = false
	left_front_thruster.emitting = false
	right_front_thruster.emitting = false
	

func _physics_process(delta):
	if global_position.length() > 25000:
		_respawn()

	var rotation_dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	var thrust = Input.get_action_strength("forward")
	var slow = Input.get_action_strength("backward")

	#rotation_degrees += rotation_speed * rotation_dir * delta
	apply_torque(rotation_speed * rotation_dir)

	var forward_dir = Vector2(cos(rotation), sin(rotation))

	if thrust > 0:
		handle_thrust(forward_dir, delta)
	elif slow > 0:
		handle_slow(forward_dir, delta)
	else:
		_stop()
		
	if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		set_linear_velocity(new_speed)



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
	#apply_central_force(force)
	apply_force(force / 2, left_back_thruster.global_position - global_position)
	apply_force(force / 2, right_back_thruster.global_position - global_position)
	_forward()


func handle_slow(forward_dir, delta):
	var force = -(forward_dir * acceleration)
	#apply_central_force(force)
	apply_force(force / 2, left_front_thruster.global_position - global_position)
	apply_force(force / 2, right_front_thruster.global_position - global_position)
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
