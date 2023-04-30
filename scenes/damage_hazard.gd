extends Area2D

@onready var player: Node2D = get_node("/root/space/Spaceship")
@export var damage_amount: float = 1


func setup(tex: Texture2D):
	var size = tex.get_size()
	$Shape.shape.radius = min(size.x, size.y) / 2
	$Sprite.texture = tex
	$Collider/ColliderShape.shape.radius = min(size.x, size.y) / 2 - 20

func _handle_body_enter(body: RigidBody2D):
	player.damage.emit(damage_amount, body)

func _ready():
	connect("body_entered", _handle_body_enter)
