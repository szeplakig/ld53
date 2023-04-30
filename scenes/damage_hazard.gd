extends StaticBody2D

@onready var player: Node2D = get_node("/root/space/Spaceship")



func setup(tex: Texture2D):
	var size = tex.get_size()
	$Shape.shape.radius = (min(size.x, size.y) - 10) / 2 
	$Sprite.texture = tex
