extends Node2D

@export var station_id = 1
@export var interact_radius: float = 10

@onready var player = get_node("/root/space/Spaceship")
@onready var shape = $Shape
@onready var arrow = $TargetArrow
@onready var text = $Control/Panel/RichTextLabel
@onready var assignment_manager = get_node("/root/space/AssigmentManager")



func interact():
	pass


func _process(delta):
	if Input.is_action_just_released("interact") and (player.global_position - global_position).length() <= interact_radius:
		interact()


func _ready():
	interact_radius = shape.shape.radius
