extends Node2D
class_name GameManager

export(PackedScene) onready var applicant_scene
export(PackedScene) onready var decision_applicant_scene
export(PackedScene) onready var interaction_dialog_scene

var applicant_list = []
var current_applicant_index = 0

var companyComputerDecision: ValidationCompanyComputer
var current_interaction_dialog: InteractionDialog


func _ready():
	$MainScene/CurrentMonth.text = "Current month: " + String(Global.current_month)
	_instantiate_panels()
	_wire_events()
	_load_next_applicant()


func _wire_events():
	companyComputerDecision.connect("decision_made", self, "_apply_applicant_decision")
	companyComputerDecision.connect("decision_cancel", self, "on_unload_company_validation")
	$MainScene/EndWorkingDayButton.connect("pressed", self, "_on_working_day_ended")
	current_interaction_dialog.connect("reference_used", self, "_on_reference_used")
	$MainScene/MainComputer.connect("interaction_started", self, "_on_interaction_started")
	$MainScene/MainComputer.connect("interaction_ended", self, "_on_interaction_ended")
	$MainScene/CompanyComputer.connect("show_computer_validation", self, "on_load_company_validation")# mostrar panel decision
	$MainScene/CompanyComputer.connect("end_computer_validation", self, "on_unload_company_validation")#ocultar panel decision
	

func _on_reference_used(reference):
	if reference is SkillPanel:
		reference.skill_asked()
	elif reference is JobRequisite:
		reference.requisite_asked()

func on_new_applicant_computer(applicant):#inicia mainComputer con el applicant actual
	$MainScene/MainComputer._load_applicant_computer(applicant)


func on_unload_applicant_computer(applicant):#inicia mainComputer con el applicant actual
	$MainScene/MainComputer._unload_applicant_computer()
	_on_interaction_ended(applicant)


func on_load_company_validation():
	companyComputerDecision.visible = true
	var tween = create_tween()
	tween.tween_property(companyComputerDecision, "modulate:a", 1, 3)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)

func on_unload_company_validation():
	companyComputerDecision.visible = false


func on_load_company_computer():#inicia mainComputer con el applicant actual
	$MainScene/CompanyComputer._load_company_computer()


func on_unload_company_computer():#inicia mainComputer con el applicant actual
	$MainScene/CompanyComputer._unload_company_computer()

func _on_interaction_started(applicant):
	$MainScene/CVContainer.visible = true
	$MainScene/CVContainer.add_child(applicant.get_cv())
	$MainScene/JobOfferContainer.visible = true
	$MainScene/JobOfferContainer.add_child(applicant.get_job_offer())
	applicant.get_cv().connect("skill_selected", self, "_on_skill_selected")
	applicant.get_job_offer().connect("job_requisite_selected", self, "_on_job_requisite_selected")


func _on_interaction_ended(applicant):
	$MainScene/CVContainer.visible = false
	$MainScene/CVContainer.remove_child(applicant.get_cv())
	$MainScene/JobOfferContainer.visible = false
	$MainScene/JobOfferContainer.remove_child(applicant.get_job_offer())


func _on_skill_selected(skill: SkillPanel):
	applicant_list[current_applicant_index].get_cv().idle_other_skills(skill)
	applicant_list[current_applicant_index].get_job_offer().idle_other_requisites(null)
	current_interaction_dialog.add_interaction_line(
		QuestionAnswer.new(skill.skill_question, skill.skill_answer)
			, skill)


func _on_job_requisite_selected(job_requisite: JobRequisite):
	applicant_list[current_applicant_index].get_job_offer().idle_other_requisites(job_requisite)
	applicant_list[current_applicant_index].get_cv().idle_other_skills(null)
	current_interaction_dialog.add_interaction_line(
		QuestionAnswer.new(job_requisite.requisite_question, job_requisite.requisite_answer)
			, job_requisite)


func _apply_applicant_decision(evaluationStatus: String):
	var current_applicant = applicant_list[current_applicant_index]
	if (
			current_applicant.get_status() is StateApplicantReviewing 
			and current_applicant.get_cv().get_status() is StateCVActive
		):
			_process_applicant(current_applicant, evaluationStatus)


func _instantiate_panels():
	# Static Panels
	companyComputerDecision = get_node("MainScene/ValidationCompanyComputer")
	current_interaction_dialog = interaction_dialog_scene.instance()
	$MainScene/InteractionDialogContainer.add_child(current_interaction_dialog)

	# Dynamic Panels
	for puzzle in PuzzleManager.get_all_puzzle():
		var new_applicant = applicant_scene.instance()
		new_applicant.add_data(puzzle.applicant_name,
			puzzle.skills_answers, puzzle.requisites_answers, puzzle.company_name, puzzle.category_job, puzzle.validate_solution, puzzle.payment_salary, puzzle.detail_validations)
		new_applicant.set_positions_applicant($MainScene/ApplicantContainer/ApplicantEntrancePosition.position,$MainScene/ApplicantContainer/ApplicantInterviewPosition.position)
		applicant_list.append(new_applicant)
		wired_events_applicant(new_applicant)


func wired_events_applicant(new_applicant: Applicant):
	new_applicant.connect("load_computer_applicant", self, "on_new_applicant_computer")
	new_applicant.connect("unload_computer_applicant", self, "on_unload_applicant_computer")
	new_applicant.connect("load_company_computer_applicant", self, "on_load_company_computer")
	new_applicant.connect("unload_company_computer_applicant", self, "on_unload_company_computer")

func _on_working_day_ended():
	var list_applicant_result = []
	for applicant in applicant_list:
		list_applicant_result.append(applicant.evaluation)
		if applicant.get_status() is StateApplicantEvaluated:
			if applicant.get_cv().get_status() is StateCVApproved:
				print("Applicant %s is accepted, it was valid?: %s" 
					% [applicant.applicant_name, applicant.is_valid_applicant])
			elif applicant.get_cv().get_status() is StateCVRejected:
				print("Applicant %s is rejected, it was valid?: %s" 
					%  [applicant.applicant_name, applicant.is_valid_applicant])
	Global.set_applicants_result_for_day(list_applicant_result)
	LoadManager.load_scene(self,"res://scenes/game/items/resume/applicant_resume.tscn")


func _process_applicant(applicant: Applicant, evaluationStatus: String):
	applicant.process_applicant(evaluationStatus)
	process_validations_applicant(applicant)
	current_applicant_index += 1
	on_unload_company_validation()
	_load_next_applicant()


func process_validations_applicant(applicant: Applicant):
	for detail in applicant.detail_validations:
		if detail.type_special_condition == EnumUtils.typeSpecialCondition.correct_applicant:
			if applicant.is_valid_applicant == true && applicant.evaluation.current_status == ApplicantResult.Status.keys()[ApplicantResult.Status.VALID]:
				detail._set_value(detail.value_text_OK,detail.value_OK)
			else:
				detail._set_value(detail.value_text_NOK,detail.value_NOK)
		applicant.evaluation.details_applicant = applicant.detail_validations


func _load_next_applicant():
	if applicant_list.size() - 1 >= current_applicant_index:
		$MainScene/ApplicantContainer/VBoxContainer.add_child(applicant_list[current_applicant_index])
	else:
		$MainScene/EndWorkingDayButton.visible = true
