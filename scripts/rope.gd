extends Node2D

var piece_length := 6.0
var rope_parts := []
var rope_close_tolerance := 8.0
var rope_points : Array[Node2D] = []
var rope_to_left := true

@export_color_no_alpha var color = Color.LIGHT_GRAY

@export var rope_pieces: Array = []

func _process(delta):
	rope_points = []
	for piece in rope_pieces:
		rope_points.append(piece.global_position)
	

func _draw():
	if rope_points.size() > 2:
		draw_multiline(rope_points, color, 2.0)
