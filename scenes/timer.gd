extends Control

@onready var assignment_manager = get_node("/root/space/AssigmentManager")
@export var target_time: float = 60
var time_left = 0
@onready var label = $CanvasLayer/Panel/Label


enum {stopped, running, failed, finished}
var current_state = stopped

func _ready():
	assignment_manager.assignment_state_change.connect(assignment_state_change_handler)


func assignment_state_change_handler(state, assignment):
	if state == assignment_manager.AssignmentState.TAKEN:
		target_time = assignment.time_allowance
		current_state = running
		$Timer.start(target_time)
	elif state == assignment_manager.AssignmentState.FAILED:
		current_state = failed
		time_left = $Timer.time_left
		$Timer.stop()
	elif state == assignment_manager.AssignmentState.FINISHED:
		current_state = finished
		time_left = $Timer.time_left
		$Timer.stop()
	else:
		current_state = stopped
		time_left = $Timer.time_left
		$Timer.stop()


func _process(delta):
	if current_state == running:
		label.text = "Time left: " + str(max(0, round($Timer.time_left))) + " seconds"
	elif current_state == failed:
		label.text = "Failed!"
	elif current_state == finished:
		label.text = "Finished in " + str(max(0, round(target_time - time_left))) + " seconds"
	else:
		label.text = ""
		

func _on_Timer_timeout():
	if current_state == running:
		current_state = failed
