extends Node2D

export(PackedScene) var cvScene
export(PackedScene) var jobOfferScene
export(PackedScene) var applicantScene
export(PackedScene) var decisionApplicantScene

var applicationResultClass = load("res://scenes/game/characters/applicantResult.gd")
var listApplResults 


var mouse_over = false
var event_fired = false

func _ready():
#	instantiate panels and signals for UI elements to the gameManager
	_instantiate_panels()

func _on_Panel_mouse_entered():
	mouse_over = true

func _on_Panel_mouse_exited():
	mouse_over = false
	event_fired = false

func _on_Panel_gui_input(event,result):
	if event is InputEventMouseButton:
		if mouse_over == true && event_fired == false:
			print(result)
			event_fired = true

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
	okButton._instantiate_connect(get_node("."))
	nokButton._instantiate_connect(get_node("."))
