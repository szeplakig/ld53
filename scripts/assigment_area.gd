extends Node2D

@onready var player = get_node("/root/space/Spaceship")
@onready var shape = $Shape
@onready var arrow = $TargetArrow
@onready var text = $Control/Panel/Label
@onready var assignment_manager = get_node("/root/space/AssigmentManager")

@export var interact_radius: float = 10


func interact():
	assignment_manager.step_state.emit('take')


func _ready():
	interact_radius = shape.shape.radius
	assignment_manager.assignment_state_change.connect(assignment_state_change_handler)
	text.text = "Take a delivery assignment whenever you feel like!"

func _process(delta):
	if Input.is_action_just_released("interact") and (player.global_position - global_position).length() <= interact_radius:
		interact()

func spawn_cargo(cargo):
	player.drop_cargo()
	player.take_cargo(cargo)

func assignment_state_change_handler(state, assignment):
	print("assignment_state_change_handler")
	if state == assignment_manager.AssignmentState.TAKEN and assignment != null:
		text.text = assignment.description
		spawn_cargo(assignment.resources)
	elif state == assignment_manager.AssignmentState.NOT_TAKEN:
		text.text = "Take a delivery assignment whenever you feel like!"
	elif state == assignment_manager.AssignmentState.FAILED:
		text.text = "No worries, you failed your last assignment, but you can try it again!"
	elif state == assignment_manager.AssignmentState.FINISHED:
		text.text = "Thank you finishing that assignment! You can take another another one anytime."
	
