extends Node2D

@export var should_rotate = true
@export var max_show_distance = 10000
@export var offset = Vector2(20, 20)

@onready var target = get_node("/root/space/Spaceship")
@onready var sprite = $Node2D

var min_scale = Vector2(0.1, 0.1)
var max_scale = Vector2(1.0, 1.0)
var _on = true

func on():
	_on = true

func off():
	_on = false

func _physics_process(delta):
	if not _on:
		hide()
		return

	var distance = (sprite.global_position - global_position).length()

	if distance > max_show_distance:
		hide()
		return
	else:
		show()
		var t = 1.0 - (distance / max_show_distance)
		scale = min_scale.lerp(max_scale, t)

	var canvas = get_canvas_transform()
	var top_left = (-canvas.origin + offset) / canvas.get_scale()
	var size = (get_viewport_rect().size - offset * 2) / canvas.get_scale()
	
	set_marker_position(Rect2(top_left, size))
	if should_rotate:
		set_marker_rotation()
	else:
		sprite.global_rotation = 0
	


func set_marker_position(bounds: Rect2):
	if target == null:
		sprite.global_position.x = clampf(global_position.x, bounds.position.x, bounds.end.x)
		sprite.global_position.y = clampf(global_position.y, bounds.position.y, bounds.end.y)
	else:
		var target_position = target.global_position
		var displacement = global_position - target_position
		var length = null
		
		var tl = (bounds.position - target_position).angle()
		var tr = (Vector2(bounds.end.x, bounds.position.y) - target_position).angle()
		var bl = (Vector2(bounds.position.x, bounds.end.y) - target_position).angle()
		var br = (bounds.end - target_position).angle()
		
		var dp_angle = displacement.angle()
		
		if (dp_angle > tl && dp_angle < tr) || (dp_angle < bl && dp_angle > br):
			var y_length = clampf(displacement.y, bounds.position.y - target_position.y, bounds.end.y - target_position.y)
			var angle = dp_angle - PI / 2.0
			length = y_length / cos(angle) if cos(angle) != 0 else y_length
		else:
			var x_length = clampf(displacement.x, bounds.position.x - target_position.x, bounds.end.x - target_position.x)
			var angle = dp_angle
			length = x_length / cos(angle) if cos(angle) != 0 else x_length
			
		sprite.global_position = polar2cartesian(length, dp_angle) + target_position

	if bounds.has_point(global_position):
		hide()
	else:
		show()

func set_marker_rotation():
	var angle = (global_position - sprite.global_position).angle()
	sprite.global_rotation = angle

func polar2cartesian(r, th):
	return Vector2(r * cos(th), r * sin(th))
	
