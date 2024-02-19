extends Node2D
class_name GameManager

export(PackedScene) var cvScene
export(PackedScene) var jobOfferScene
export(PackedScene) var applicantScene
export(PackedScene) var decisionApplicantScene

var applicationResultClass = load("res://scenes/game/characters/applicantResult.gd")
var listApplResults:Array = []

var current_job_offer: JobOffer
var curent_cv : Curriculum
var current_aplicant: Applicant
var current_decision_applicant: DecisionApplicant

func _ready():
#	instantiate panels and signals for UI elements to the gameManager
	_instantiate_panels()
	current_aplicant = get_node("MainScene/ApplicantContainer/Applicant")
	current_job_offer = get_node("MainScene/JobOfferContainer/JobOffer")
	current_decision_applicant = get_node("MainScene/DecisionApplContainer/DecisionApplicant")
	_wire_events()


func _wire_events():
	current_aplicant.connect("interaction_started", self, "_on_interaction_started")
	current_aplicant.connect("interaction_ended", self, "_on_interaction_ended")
	current_decision_applicant.connect("decision_made", self, "_apply_applicant_decision")


func _on_interaction_started():
	var cv_container = get_node("MainScene/CVContainer")
	cv_container.visible = true
	# TODO: recoger el CV del candidato en lugar de crear uno nuevo
	curent_cv = cvScene.instance()
	cv_container.add_child(curent_cv)
	
	
func _on_interaction_ended():
	var cv_container = get_node("MainScene/CVContainer")
	cv_container.visible = false
	cv_container.remove_child(curent_cv)

func _apply_applicant_decision(result):
	print("Your choice has been: %s, applicant was: %s" % [result, current_aplicant])

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
