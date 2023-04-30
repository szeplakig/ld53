extends Area2D

@onready var player: Node2D = get_node("/root/space/Spaceship")
@export var slowdown_amount: float = 2


func setup(tex: Texture2D):
	var size = tex.get_size()
	$Shape.shape.radius = min(size.x, size.y) / 2
	$Sprite.texture = tex

func _handle_body_enter(body: RigidBody2D):
	player.slowdown.emit(slowdown_amount, body)

func _ready():
	connect("body_entered", _handle_body_enter)

func _process(delta):
	pass
