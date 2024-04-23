extends Panel

class_name ValidationCompanyComputer

signal decision_made(decision)
signal decision_cancel()

func _ready():
	$ButtonOK.connect("pressed", self, "_on_button_ok_pressed")
	$ButtonNOK.connect("pressed", self, "_on_button_no_ok_pressed")
	$ButtonCancel.connect("pressed", self, "_on_button_cancel")

func _on_button_ok_pressed():
	emit_signal("decision_made",ApplicantResult.Status.keys()[ApplicantResult.Status.VALID])


func _on_button_no_ok_pressed():
	emit_signal("decision_made", ApplicantResult.Status.keys()[ApplicantResult.Status.NOT_VALID])


func _on_button_cancel():
	emit_signal("decision_cancel")

