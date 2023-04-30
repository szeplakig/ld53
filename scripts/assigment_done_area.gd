extends Node2D

@export var station_id: int = 0
@export var interact_radius: float = 10

@onready var player = get_node("/root/space/Spaceship")
@onready var shape = $Shape
@onready var arrow = $TargetArrow
@onready var text = $Control/Panel/RichTextLabel
@onready var assignment_manager = get_node("/root/space/AssigmentManager")

var current_assignment = null

func _ready():
	interact_radius = shape.shape.radius
	assignment_manager.assignment_state_change.connect(assignment_state_change_handler)


func assignment_state_change_handler(state, assignment):
	var mine = false
	if state == assignment_manager.AssignmentState.TAKEN:
		if assignment.target == station_id:
			arrow.show()
			text.text = "Waiting for delivery..."
			current_assignment = assignment
		else:
			arrow.hide()
			text.text = "Not here!"
			current_assignment = null
	else:
		arrow.hide()

func interact():
	if current_assignment and current_assignment.target == station_id:
		if current_assignment.resources == player.cargo:
			text.text = "Thank you for the delivery!"
			assignment_manager.step_state.emit('finished')
		else:
			text.text = "You did not manage to get all resources here in one piece... :("
			assignment_manager.step_state.emit('failed')
		player.empty_cargo()
			


func _process(delta):
	if Input.is_action_just_released("interact") and (player.global_position - global_position).length() <= interact_radius:
		interact()
