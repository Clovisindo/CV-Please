extends Control

class_name DecisionApplicant

signal decision_made(decision)

func _ready():
	$DecisionOKButton.connect("pressed", self, "_on_button_ok_pressed")
	$DecisionNOKButton.connect("pressed", self, "_on_button_no_ok_pressed")

func _on_button_ok_pressed():
	emit_signal("decision_made", EnumUtils.ApplicantResult.VALID)

func _on_button_no_ok_pressed():
	emit_signal("decision_made", EnumUtils.ApplicantResult.NOT_VALID)
