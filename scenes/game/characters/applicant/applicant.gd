extends Panel

class_name Applicant

export (Texture) var portrait 
var appl_name
var applResult:applicationResult = applicationResult.new()

onready var state_machine = $StateMachine
onready var applicant_name = $Name

signal interaction_started()
signal interaction_ended()

func _ready():
	_set_applicant_data(portrait,"applicant 1")
	state_machine.init(self)

#TODO carga dinamica de los applicants al currentApplicant en la UI
func _set_applicant_data( texture, name):
	$Portrait.texture = texture
	$Name.set_bbcode("[center]%s[/center]" % name)
	applResult._init_appl_result(EnumUtils.ApplicantResult.VALID)

func _get_application_result():
	return applResult

func _gui_input(event):
	$StateMachine.current_state.handle_input(event)

func show_cv(show: bool):
	if show:
		emit_signal("interaction_started")
	else:
		emit_signal("interaction_ended")
