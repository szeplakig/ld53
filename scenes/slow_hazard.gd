extends Area2D

@onready var player: Node2D = get_node("/root/space/Spaceship")

var entered_bodies = []

func setup(tex: Texture2D):
	var size = tex.get_size()
	$Shape.shape.radius = max(size.x, size.y) / 2
	$Sprite.texture = tex


func _physics_process(delta):
	var max_distance = $Shape.shape.radius
	for body in entered_bodies:
		var distance_to_center = (body.global_position - global_position).length()
		var force_strength = lerp(0, 5000, distance_to_center / max_distance)
		body.apply_central_force(-body.linear_velocity.normalized() * force_strength * delta)


func _on_body_entered(body):
	if body is RigidBody2D:
		if not body.has_meta("slowdown_count"):
			body.set_meta("slowdown_count", 1)
			entered_bodies.append(body)
		else:
			var slowdown_count = body.get_meta("slowdown_count")
			if slowdown_count < 3:
				body.set_meta("slowdown_count", slowdown_count + 1)
				entered_bodies.append(body)


func _on_body_exited(body):
	if body is RigidBody2D:
		if body.has_meta("slowdown_count"):
			var slowdown_count = body.get_meta("slowdown_count")
			body.set_meta("slowdown_count", slowdown_count - 1)
			entered_bodies.erase(body)

