extends StateApplicant

class_name StateApplicantWaiting


func entrance_applicant():
	emit_signal("transitioned", "Entrance")
