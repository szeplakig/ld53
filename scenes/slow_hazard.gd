extends Area2D

@onready var player: Node2D = get_node("/root/space/Spaceship")


func setup(tex: Texture2D):
	var size = tex.get_size()
	$Shape.shape.radius = max(size.x, size.y) / 2
	$Sprite.texture = tex

func _handle_body_enter(body: RigidBody2D):
	print('enter')
	body.apply_central_impulse(-body.linear_velocity.normalized() * 10000)

func _process(delta):
	pass
