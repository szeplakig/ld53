extends PhysicsBody2D

@export var acceleration: float = 10
@export var deceleration: float = 10
@export var rotation_speed: float = 100
@export var max_speed: float = 5

var velocity = Vector2()


func _physics_process(delta):
	var rotation_dir = Input.get_action_strength("right") - Input.get_action_strength("left")

	var thrust = Input.get_action_strength("forward")
	var slow = Input.is_action_pressed("backward")

	rotation_degrees += rotation_speed * rotation_dir * delta

	var forward_dir = Vector2(cos(rotation), sin(rotation))
	var acceleration_vec = Vector2()
	if thrust > 0 and not slow:
		acceleration_vec += forward_dir * acceleration
		
	elif not thrust and rotation_dir == 0:
		if velocity.length() > 0:
			var deceleration_vec = -velocity.normalized() * deceleration
			velocity += deceleration_vec * delta
	
	velocity += acceleration_vec * delta
	

	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	if velocity.length() < 0.01:
		velocity = Vector2()

	move_and_collide(velocity)
