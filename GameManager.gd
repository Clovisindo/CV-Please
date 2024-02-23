extends Node2D
class_name GameManager

export(PackedScene) onready var job_offer_scene
export(PackedScene) onready var applicant_scene
export(PackedScene) onready var decision_applicant_scene
export(PackedScene) onready var puzzle_manager_scene

var puzzle_manager: PuzzleManager
var applicant_list = []

var current_job_offer: JobOffer
var current_decision_applicant: DecisionApplicant

func _ready():
	_instantiate_panels()
	_wire_events()


func _wire_events():
	current_decision_applicant.connect("decision_made", self, "_apply_applicant_decision")
	$MainScene/EndWorkingDayButton.connect("pressed", self, "_on_working_day_ended")


func _on_interaction_started(applicant):
	var cv_container = get_node("MainScene/CVContainer")
	cv_container.visible = true
	cv_container.add_child(applicant.get_cv())
	for each in applicant_list:
		if not each == applicant:
			each.lock_applicant(true)


func _on_interaction_ended(applicant):
	var cv_container = get_node("MainScene/CVContainer")
	cv_container.visible = false
	cv_container.remove_child(applicant)
	for each in applicant_list:
		if not each == applicant:
			each.lock_applicant(false)


func _apply_applicant_decision(result):
	var evaluation = ApplicantResult.new()
	evaluation.current_status = result
	for applicant in applicant_list:
		if applicant.get_status() is StateApplicantReviewing:
			applicant.process_applicant(evaluation)


func _instantiate_panels():
	# Static Panels
	current_job_offer = job_offer_scene.instance()
	$MainScene/JobOfferContainer.add_child(current_job_offer)
	current_decision_applicant = decision_applicant_scene.instance()
	$MainScene/DecisionApplContainer.add_child(current_decision_applicant)

	# Dynamic Panels
	puzzle_manager = puzzle_manager_scene.instance()
	var puzzles = puzzle_manager.get_all_puzzle()
	for puzzle in puzzles:
		var new_applicant = applicant_scene.instance()
		new_applicant.add_data(puzzle.applicant_name, puzzle.skills_answers)
		$MainScene/ApplicantContainer/VBoxContainer.add_child(new_applicant)
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
