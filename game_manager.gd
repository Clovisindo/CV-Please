extends Node2D
class_name GameManager

export(PackedScene) onready var applicant_scene
export(PackedScene) onready var decision_applicant_scene

var applicant_list = []
var current_applicant_index = 0

var current_decision_applicant: DecisionApplicant

func _ready():
	_instantiate_panels()
	_wire_events()
	_load_next_applicant()


func _wire_events():
	current_decision_applicant.connect("decision_made", self, "_apply_applicant_decision")
	$MainScene/EndWorkingDayButton.connect("pressed", self, "_on_working_day_ended")


func _on_interaction_started(applicant):
	$MainScene/CVContainer.visible = true
	$MainScene/CVContainer.add_child(applicant.get_cv())
	$MainScene/JobOfferContainer.visible = true
	$MainScene/JobOfferContainer.add_child(applicant.get_job_offer())


func _on_interaction_ended(applicant):
	$MainScene/CVContainer.visible = false
	$MainScene/CVContainer.remove_child(applicant.get_cv())
	$MainScene/JobOfferContainer.visible = false
	$MainScene/JobOfferContainer.remove_child(applicant.get_job_offer())


func _apply_applicant_decision(evaluation: ApplicantResult):
	var current_applicant = applicant_list[current_applicant_index]
	if (
			current_applicant.get_status() is StateApplicantReviewing 
			and current_applicant.get_cv().get_status() is StateCVActive
		):
			_process_applicant(current_applicant, evaluation)


func _instantiate_panels():
	# Static Panels
	current_decision_applicant = decision_applicant_scene.instance()
	$MainScene/DecisionApplContainer.add_child(current_decision_applicant)

	# Dynamic Panels
	for puzzle in PuzzleManager.get_all_puzzle():
		var new_applicant = applicant_scene.instance()
		new_applicant.add_data(puzzle.applicant_name, puzzle.skills_answers,
			puzzle.requisites_answers)
		applicant_list.append(new_applicant)
		new_applicant.connect("interaction_started", self, "_on_interaction_started")
		new_applicant.connect("interaction_ended", self, "_on_interaction_ended")


func _on_working_day_ended():
	for applicant in applicant_list:
		if applicant.get_status() is StateApplicantEvaluated:
			if applicant.get_cv().get_status() is StateCVApproved:
				print("Applicant %s is accepted" % applicant.applicant_name)
			elif applicant.get_cv().get_status() is StateCVRejected:
				print("Applicant %s is rejected" % applicant.applicant_name)

func _process_applicant(applicant: Applicant, evaluation: ApplicantResult):
	applicant.process_applicant(evaluation)
	$MainScene/ApplicantContainer/VBoxContainer.remove_child(applicant)
	current_applicant_index += 1
	_load_next_applicant()

func _load_next_applicant():
	if applicant_list.size() - 1 >= current_applicant_index:
		$MainScene/ApplicantContainer/VBoxContainer.add_child(applicant_list[current_applicant_index])
	else:
		$MainScene/EndWorkingDayButton.visible = true
