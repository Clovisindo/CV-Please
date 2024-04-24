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

var entrance_position :Vector2
var interview_position :Vector2

var company_name 
var category_job
var salary_payment

signal load_computer_applicant()
signal unload_computer_applicant()
signal load_company_computer_applicant()
signal unload_company_computer_applicant()


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

func process_applicant(resultStatus):
	var result = ApplicantResult.new(applicant_name,"",category_job,company_name,resultStatus, salary_payment,null)
	evaluation = result
	$StateMachine.current_state.process_applicant()


func set_positions_applicant(_entrace_position, _interview_position):
	entrance_position = _entrace_position
	interview_position = _interview_position

func _load_applicant_computer():
	emit_signal("load_computer_applicant", self)


func _unload_applicant_computer():
	emit_signal("unload_computer_applicant", self)

func _load_company_computer():
	emit_signal("load_company_computer_applicant")


func _unload_company_computer():
	emit_signal("unload_company_computer_applicant")

func get_status():
	return $StateMachine.current_state
