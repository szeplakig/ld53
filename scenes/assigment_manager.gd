extends Node2D

@export var assignment_data: Node2D = null
@export var station_0: Node2D = null
@export var station_1: Node2D = null
@export var station_2: Node2D = null
@export var station_3: Node2D = null
@export var station_4: Node2D = null
@export var station_5: Node2D = null
@export var cargo_map: Dictionary = {}

var assigmentent_index = 0


signal step_state(state_input: String)
signal assignment_state_change(state, assignment)

enum AssignmentState {
	NOT_TAKEN,
	TAKEN,
	FINISHED,
	FAILED
}
var current_state = AssignmentState.NOT_TAKEN
var current_assignment = null

func transition_to_taken(prev: AssignmentState):
	if not [AssignmentState.FAILED, AssignmentState.FINISHED, AssignmentState.NOT_TAKEN].has(prev):
		return false
	current_state = AssignmentState.TAKEN
	print("Assignment has been taken.")
	if prev != AssignmentState.FAILED:
		select_next_assigment()
		
	start_current_assignment()
	return true
	
func transition_to_finished(prev: AssignmentState):
	if not [AssignmentState.TAKEN].has(prev):
		return false
	current_state = AssignmentState.FINISHED
	print("Assignment has been completed!")
	return true
	
func transition_to_failed(prev: AssignmentState):
	if not [AssignmentState.TAKEN].has(prev):
		return false
	current_state = AssignmentState.FAILED
	print("Assignment has failed.")
	return true
	
func reset():
	current_state = AssignmentState.NOT_TAKEN
	print("Assignment has been reset to not taken.")
	return true


func step(state_input: String):
	print("current_state: ", current_state)

	var succ = false
	match state_input:
		"take":
			succ = transition_to_taken(current_state)
		"finished":
			succ = transition_to_finished(current_state)
		"failed":
			succ = transition_to_failed(current_state)
	if succ:
		print('Successful state change to ', state_input)
	else:
		print('Bad state change: ', state_input)

func select_next_assigment():
	if assigmentent_index < assignment_data.file_data.easy.size():
		print('easy')
		current_assignment = assignment_data.file_data.easy[assigmentent_index]
	elif assigmentent_index < assignment_data.file_data.easy.size() + assignment_data.file_data.medium.size():
		print('medium')
		current_assignment = assignment_data.file_data.medium[assigmentent_index - assignment_data.file_data.easy.size()]
	elif assigmentent_index < assignment_data.file_data.easy.size() + assignment_data.file_data.medium.size() + assignment_data.file_data.hard.size():
		print('hard')
		current_assignment = assignment_data.file_data.hard[assigmentent_index - assignment_data.file_data.easy.size() + assignment_data.file_data.medium.size()]
	else:
		print('none left')
		current_assignment = null
	assigmentent_index += 1

func start_current_assignment():
	assignment_state_change.emit(current_state, current_assignment)

func _ready():
	step_state.connect(step)


func _process(delta):
	pass
