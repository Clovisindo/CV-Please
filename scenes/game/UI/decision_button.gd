extends Control

class_name DecisionApplicant

signal decision_made(decision)

func _ready():
	$DecisionOKButton.connect("pressed", self, "_on_button_ok_pressed")
	$DecisionNOKButton.connect("pressed", self, "_on_button_no_ok_pressed")

func _on_button_ok_pressed():
	var result = ApplicantResult.new()
	result.current_status = ApplicantResult.Status.VALID
	emit_signal("decision_made", result)

func _on_button_no_ok_pressed():
	var result = ApplicantResult.new()
	result.current_status = ApplicantResult.Status.NOT_VALID
	emit_signal("decision_made", result)
