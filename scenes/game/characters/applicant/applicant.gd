extends Panel

class_name Applicant

export(Texture) onready var portrait_texture
export(PackedScene) onready var curriculum_scene

var cv: Curriculum
var evaluation: ApplicantResult
var applicant_name = "Default name"

signal interaction_started()
signal interaction_ended()

func add_data(name: String, skills: Dictionary):
	if name:
		applicant_name = name
		$Container/Name.bbcode_text = "[center]%s[/center]" % name
	if skills:
		cv = curriculum_scene.instance()
		cv.add_skills(skills)

func _ready():
	$StateMachine.init(self)
	$Container/PortraitRect/Portrait.texture = portrait_texture

func get_cv():
	return self.cv


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func show_cv(show: bool):
	if show:
		emit_signal("interaction_started", self)
	else:
		emit_signal("interaction_ended", self)


func process_applicant(result):
	evaluation = result
	$StateMachine.current_state.process_applicant()
	
	
func lock_applicant(is_locked: bool):
	$StateMachine.current_state.lock_applicant(is_locked)

func get_status():
	return $StateMachine.current_state
