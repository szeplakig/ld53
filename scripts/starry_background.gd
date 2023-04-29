extends Node2D

# Number of stars
@export var star_count: int = 2000
@export var min_scale: float = 0.01
@export var max_scale: float = 0.1
@export var screen_size: Vector2 = Vector2(2000, 2000)



func _ready():
	generate_stars()

func generate_stars():
	for i in range(star_count*4):
		var star = create_star()
		add_child(star)

func create_star() -> Node2D:
	var star = Sprite2D.new()
	var scl = randf_range(min_scale, max_scale)
	var pos = Vector2(randi_range(-screen_size.x, screen_size.x), randi_range(-screen_size.y, screen_size.y))
	star.position = pos
	star.rotate(randf_range(0, TAU))
	star.texture = load("res://assets/star.png")
	star.apply_scale(Vector2(scl, scl))

	return star
