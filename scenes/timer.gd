extends Control

@onready var assignment_manager = get_node("/root/space/AssigmentManager")
@export var target_time: float = 60
var time_left = 0
@onready var timer_label = $CanvasLayer/Panel/Label
@onready var score_label = $CanvasLayer/Panel2/Label
@onready var time_sound = get_node("/root/space/Spaceship/Time")


enum {stopped, running, failed, finished}
var current_state = stopped
var next_time_sound = null
var score = 0

func _ready():
	assignment_manager.assignment_state_change.connect(assignment_state_change_handler)


func assignment_state_change_handler(state, assignment):
	if state == assignment_manager.AssignmentState.TAKEN:
		target_time = assignment.time_allowance
		next_time_sound = target_time - 10.01
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
		score += (target_time - time_left) * 100
	else:
		current_state = stopped
		time_left = $Timer.time_left
		$Timer.stop()


func _process(delta):
	score_label.text = "Score: " + str(round(score))
	if current_state == running:
		var t = round($Timer.time_left)
		timer_label.text = "Time left: " + str(max(0, t)) + " seconds"
		if t < next_time_sound:
			time_sound.play()
			next_time_sound -= 10
	elif current_state == failed:
		timer_label.text = "Failed!"
	elif current_state == finished:
		timer_label.text = "Finished in " + str(max(0, round(target_time - time_left))) + " seconds"
	else:
		timer_label.text = ""


func _on_timer_timeout():
	if current_state == running:
		current_state = failed
		timer_label.text = "Failed!"
		assignment_manager.step_state.emit('failed')
	$Timer.stop()
