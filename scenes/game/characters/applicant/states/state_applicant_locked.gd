extends StateApplicant

class_name StateApplicantLocked


func lock_applicant(is_locked: bool):
	if not is_locked:
		emit_signal("transitioned","Waiting")
