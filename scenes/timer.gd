extends Control

@onready var assignment_manager = get_node("/root/space/AssigmentManager")
@export var target_time: float = 60
@onready var label = $CanvasLayer/Panel/Label

var time_left: float = target_time

enum {stopped, running, failed, finished}
var current_state = stopped

func _ready():
	assignment_manager.assignment_state_change.connect(assignment_state_change_handler)


func assignment_state_change_handler(state, assignment):
	if state == assignment_manager.AssignmentState.TAKEN:
		target_time = assignment.time_allowance
		current_state = running
	elif state == assignment_manager.AssignmentState.FAILED:
		current_state = failed
	elif state == assignment_manager.AssignmentState.FINISHED:
		current_state = finished
	else:
		current_state = stopped
		target_time = 0
		

func start_timer():
	time_left = target_time
	$Timer.start(target_time)


func _process(delta):
	if current_state == running:
		label.text = "Time left: " + str(max(0, round($Timer.time_left))) + "s"
	elif current_state == failed:
		label.text = "Failed!"
	elif current_state == finished:
		label.text = "Finished in " + str(target_time - time_left) + "s"
	else:
		label.text = ""
		

func _on_Timer_timeout():
	time_left -= $Timer.wait_time
	if time_left > 0:
		start_timer()
	elif current_state == running:
		current_state = failed
