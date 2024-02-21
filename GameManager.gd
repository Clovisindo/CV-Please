extends Node2D
class_name GameManager

export(PackedScene) var jobOfferScene
export(PackedScene) var applicantScene
export(PackedScene) var decisionApplicantScene
export(PackedScene) var puzzle_manager_scene

var puzzle_manager
var candidates_list = []

var current_job_offer: JobOffer
var current_aplicant: Applicant
var current_decision_applicant: DecisionApplicant

func _ready():
	_instantiate_panels()
	current_aplicant = get_node("MainScene/ApplicantContainer/Applicant")
	current_job_offer = get_node("MainScene/JobOfferContainer/JobOffer")
	current_decision_applicant = get_node("MainScene/DecisionApplContainer/DecisionApplicant")
	_wire_events()


func _wire_events():
	current_aplicant.connect("interaction_started", self, "_on_interaction_started")
	current_aplicant.connect("interaction_ended", self, "_on_interaction_ended")
	current_decision_applicant.connect("decision_made", self, "_apply_applicant_decision")
	$MainScene/EndWorkingDayButton.connect("pressed", self, "_on_working_day_ended")


func _on_interaction_started():
	var cv_container = get_node("MainScene/CVContainer")
	cv_container.visible = true
	cv_container.add_child(current_aplicant.get_cv())


func _on_interaction_ended():
	var cv_container = get_node("MainScene/CVContainer")
	cv_container.visible = false
	cv_container.remove_child(current_aplicant.get_cv())


func _apply_applicant_decision(result):
	var evaluation = ApplicantResult.new()
	evaluation.current_status = result
	self.current_aplicant.process_applicant(evaluation)


func _instantiate_panels():
	var jobOfferContainer = get_node("MainScene/JobOfferContainer")
	var applicantContainer = get_node("MainScene/ApplicantContainer")
	var decisionApplContainer = get_node("MainScene/DecisionApplContainer")
	
	var jobOfferPanel = jobOfferScene.instance()
	var applicantPanel = applicantScene.instance()
	var decisionApplicantPanel = decisionApplicantScene.instance()
	
	jobOfferContainer.add_child(jobOfferPanel)
	applicantContainer.add_child(applicantPanel)
	decisionApplContainer.add_child(decisionApplicantPanel)

	puzzle_manager = puzzle_manager_scene.instance()
	var puzzles = puzzle_manager.get_all_puzzle()
	for puzzle in puzzles:
		# TODO: ahora mismo se queda cargado el último nombre creado, poder crear N applicants
		applicantPanel.set_applicant_data(null,puzzle.applicant_name)

	candidates_list.append(applicantPanel)

func _on_working_day_ended():
	for candidate in candidates_list:
		if candidate.get_status() is StateApplicantEvaluated:
			if candidate.get_cv().get_status() is StateCVApproved:
				print("Candidate %s is accepted" % candidate.name)
			elif candidate.get_cv().get_status() is StateCVRejected:
				print("Candidate %s is rejected" % candidate.name)
