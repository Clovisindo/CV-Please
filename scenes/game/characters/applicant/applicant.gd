extends Panel

class_name Applicant

export (Texture) var portrait

onready var state_machine = $StateMachine
onready var applicant_name = $Name

export(PackedScene) var cv_scene
var cv: Curriculum

var evaluation: ApplicantResult

signal interaction_started()
signal interaction_ended()


func _ready():
	set_applicant_data(portrait,"applicant 1")
	state_machine.init(self)
	cv = cv_scene.instance()


func set_applicant_data(texture, name):
	# TODO: incluir también los datos del CV
	if texture:
		$Portrait.texture = texture
	if name:
		$Name.set_bbcode("[center]%s[/center]" % name)
	

func get_cv():
	return self.cv


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func show_cv(show: bool):
	if show:
		emit_signal("interaction_started")
	else:
		emit_signal("interaction_ended")


func process_applicant(result):
	evaluation = result
	$StateMachine.current_state.process_applicant()
	

func get_status():
	return state_machine.current_state
