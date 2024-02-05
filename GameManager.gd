extends Node2D

export(PackedScene) var cvScene
export(PackedScene) var jobOfferScene
export(PackedScene) var applicantScene


# Called when the node enters the scene tree for the first time.
func _ready():
	var jobOfferContainer = get_node("MainScene/JobOfferContainer")
	var cvContainer = get_node("MainScene/CVContainer")
	var applicantContainer = get_node("MainScene/ApplicantContainer")
	
	var cvPanel = cvScene.instance()
	var jobOfferPanel = jobOfferScene.instance()
	var applicantPanel = applicantScene.instance()
	
	
	cvContainer.add_child(cvPanel)
	jobOfferContainer.add_child(jobOfferPanel)
	applicantContainer.add_child(applicantPanel)
