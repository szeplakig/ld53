extends Node2D

@onready var spaceship: RigidBody2D = get_node("/root/space/Spaceship/Body")
@export var follow: float = 0.999

var spaceship_position = Vector2()


func _ready():
	spaceship_position = spaceship.position

func _physics_process(delta):
	var velocity = spaceship_position - spaceship.position
	print(spaceship_position, spaceship.position)
	position += velocity * follow
	spaceship_position = spaceship.position
