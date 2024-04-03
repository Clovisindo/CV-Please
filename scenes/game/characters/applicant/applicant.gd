extends Panel

class_name Applicant

export(Texture) onready var portrait_texture
export(PackedScene) onready var curriculum_scene
export(PackedScene) onready var job_offer_scene

var cv: Curriculum
var job_offer: JobOffer
var evaluation: ApplicantResult
var detail_validations:Array
var applicant_name = "Default name"
var is_valid_applicant = false

var company_name 
var category_job
var salary_payment

signal interaction_started()
signal interaction_ended()


func _ready():
	$StateMachine.init(self)
	$Container/PortraitRect/Portrait.texture = portrait_texture
	$Container/Name.bbcode_text = "[center]%s[/center]" % applicant_name


func add_data(name: String, skills: Array, requisites: Array, company: String, category : String, valid: bool,payment : int, validations:Array):
	if name:
		applicant_name = name
		$Container/Name.bbcode_text = "[center]%s[/center]" % name
	if skills:
		cv = curriculum_scene.instance()
		cv.add_skills(skills)
	if requisites:
		job_offer = job_offer_scene.instance()
		job_offer.add_requisites(requisites)
	if company:
		company_name = company
	if category:
		category_job = category
	if valid:
		is_valid_applicant = valid
	if payment:
		salary_payment = payment
	if validations:
		detail_validations = validations


func get_cv():
	return self.cv
	
func get_job_offer():
	return self.job_offer


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func _applicant_selected(show: bool):
	if show:
		emit_signal("interaction_started", self)
	else:
		emit_signal("interaction_ended", self)


func process_applicant(resultStatus):
	var result = ApplicantResult.new(applicant_name,"",category_job,company_name,resultStatus, salary_payment,null)
	evaluation = result
	$StateMachine.current_state.process_applicant()


func get_status():
	return $StateMachine.current_state
