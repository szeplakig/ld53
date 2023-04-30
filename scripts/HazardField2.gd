extends Area2D

@onready var hazards = [preload("res://scenes/damage_hazard.tscn")]

@onready var area: CollisionShape2D = $Area

@export var sprites: Array[Texture2D] = []
@export var num_hazards: int = 60
@export var min_scale: float = 0.5
@export var max_scale: float = 2


func _ready():
	generate_sprites()

func generate_sprites():
	var circle_radius = area.shape.radius

	for i in range(num_hazards):
		var hazard = hazards[randi() % hazards.size()]
		var node = hazard.instantiate()
		node.setup(sprites[randi() % sprites.size()])
		var random_scale = randf_range(min_scale, max_scale)

		var random_position = Vector2(
			randf_range(-circle_radius, circle_radius),
			randf_range(-circle_radius, circle_radius)
		)

		node.position = random_position
		node.global_rotation_degrees = randf_range(0, 360)
		node.global_scale = Vector2(random_scale, random_scale)
		
		add_child(node)

