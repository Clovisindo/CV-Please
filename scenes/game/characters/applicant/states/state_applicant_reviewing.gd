extends StateApplicant

class_name StateApplicantReviewing


func process_applicant():
	emit_signal("transitioned", "Exit")
