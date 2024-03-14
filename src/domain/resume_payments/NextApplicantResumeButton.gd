extends Button

class_name NextApplicantResume

signal load_next()
signal enabled_next_resume_panel()


func _ready() -> void:
	$".".connect("pressed", self, "_on_button_ok_pressed")
	$"../..".connect("end_applicants_resume", self, "_end_list_applicants")


func _end_list_applicants():
	$".".disabled = true
	print("No more applicants in resume.")
	emit_signal("enabled_next_resume_panel")


func _on_button_ok_pressed():
	emit_signal("load_next")
