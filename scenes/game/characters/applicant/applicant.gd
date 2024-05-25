extends Panel

class_name Applicant

signal load_computer_applicant
signal unload_computer_applicant
signal load_company_computer_applicant
signal unload_company_computer_applicant

export(Texture) onready var portrait_texture
export(PackedScene) onready var curriculum_scene
export(PackedScene) onready var job_offer_scene

var cv: Curriculum
var job_offer: JobOffer
var evaluation: ApplicantResult
var cross_questions: Array
var detail_validations: Array
var applicant_name = "Default name"
var is_valid_applicant = false
var entrance_position: Vector2
var middle_position: Vector2
var interview_position: Vector2
var company_name
var category_job
var salary_payment
var salary_cv
var salary_offer
var validation_turns

var turns_count = 0


func _ready():
	$StateMachine.init(self)
	$Container/PortraitRect/Portrait.texture = portrait_texture
	$StateMachine.current_state.entrance_applicant()  # de waiting(inicio vacio) a entrance


func add_data(
	name: String,
	skills: Array,
	requisites: Array,
	company: String,
	timeline_jobs: Array,
	condition: Resource,
	cross_data: Array,
	category: String,
	valid: bool,
	payment: int,
	cv_salary: int,
	offer_salary: int,
	validations: Array,
	turns_validate: int
):
	if name:
		applicant_name = name
	if skills:
		cv = curriculum_scene.instance()
		cv.set_name_applicant(applicant_name)
		cv.add_skills(skills)
	if timeline_jobs:
		cv.add_timeline_works(timeline_jobs)
	if requisites:
		job_offer = job_offer_scene.instance()
		job_offer.add_requisites(requisites)
	if company:
		company_name = company
	if condition:
		job_offer.add_condition(condition)
	if cross_data:
		cross_questions = cross_data
	if category:
		category_job = category
		job_offer.set_type_job_label(company_name, category_job)
	if valid:
		is_valid_applicant = valid
	if payment:
		salary_payment = payment
	if cv_salary:
		cv.set_min_salary(cv_salary)
	if offer_salary:
		job_offer.set_salary_value(offer_salary)
	if validations:
		detail_validations = validations
	if turns_validate:
		validation_turns = turns_validate


func get_cv():
	return self.cv


func get_job_offer():
	return self.job_offer


func get_cross_question(requisite_text, skill_text):
	for cross_data in cross_questions:
		if (
			(cross_data.textUI == requisite_text && cross_data.textUI_secondary == skill_text)
			|| (cross_data.textUI == skill_text && cross_data.textUI_secondary == requisite_text)
		):
			return cross_data
	return null


func add_turn_count(value):
	turns_count += value
	print(" valor actual de turno :" + String(turns_count))


func _gui_input(event):
	$StateMachine.current_state.handle_input(event)


func process_applicant(result_status):
	var result = ApplicantResult.new(
		applicant_name, "", category_job, company_name, result_status, salary_payment, null
	)
	evaluation = result
	$StateMachine.current_state.process_applicant()  # de reviewing a evaluated


func set_positions_applicant(_entrace_position, _middle_position, _interview_position):
	entrance_position = _entrace_position
	middle_position = _middle_position
	interview_position = _interview_position


func load_applicant_computer():
	emit_signal("load_computer_applicant", self)


func unload_applicant_computer():
	emit_signal("unload_computer_applicant", self)


func load_company_computer():
	emit_signal("load_company_computer_applicant")


func unload_company_computer():
	emit_signal("unload_company_computer_applicant")


func get_status():
	return $StateMachine.current_state
