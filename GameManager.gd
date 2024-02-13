extends Node2D
class_name GameManager

export(PackedScene) var cvScene
export(PackedScene) var jobOfferScene
export(PackedScene) var applicantScene
export(PackedScene) var decisionApplicantScene

var applicationResultClass = load("res://scenes/game/characters/applicantResult.gd")
var listApplResults:Array = []

var currentJobOffer
var curentCV 
var currentAplicant

var mouse_over = false
var event_fired = false

func _ready():
#	instantiate panels and signals for UI elements to the gameManager
	_instantiate_panels()
	curentCV =  get_node("MainScene/CVContainer/Curriculum")
	currentAplicant = get_node("MainScene/ApplicantContainer/Applicant")
	currentJobOffer = get_node("MainScene/JobOfferContainer/JobOffer")

func _on_Panel_mouse_entered():
	mouse_over = true

func _on_Panel_mouse_exited():
	mouse_over = false
	event_fired = false

# evento de los botones de aceptar o rechazar
func _on_Panel_gui_input(event,result):
	pass
#	if event is InputEventMouseButton:
#		if mouse_over == true && event_fired == false:
#			event_fired = true
#			_apply_applicant_decision(result)

func _apply_applicant_decision(result):
	var appResult = currentAplicant._get_application_result()
	appResult._validate_result_applicant(result,100)#TODO implementar tiempo
	listApplResults.append(appResult)
	print("Your choice has been: " + str(appResult.result) + " applicant was: " + str(EnumUtils.applicantSolution.keys()[appResult.solution]))

func _instantiate_panels():
	var jobOfferContainer = get_node("MainScene/JobOfferContainer")
	var cvContainer = get_node("MainScene/CVContainer")
	var applicantContainer = get_node("MainScene/ApplicantContainer")
	var decisionApplContainer = get_node("MainScene/DecisionApplContainer")
	
	var cvPanel = cvScene.instance()
	var jobOfferPanel = jobOfferScene.instance()
	var applicantPanel = applicantScene.instance()
	var decisionApplicantPanel = decisionApplicantScene.instance()
	
	
	cvContainer.add_child(cvPanel)
	jobOfferContainer.add_child(jobOfferPanel)
	applicantContainer.add_child(applicantPanel)
	decisionApplContainer.add_child(decisionApplicantPanel)
#	create signals for decision buttons
	var okButton = decisionApplContainer.get_child(0).get_child(0)
	var nokButton = decisionApplContainer.get_child(0).get_child(1)
	okButton._instantiate_connect_decision_button(get_node("."))
	nokButton._instantiate_connect_decision_button(get_node("."))
